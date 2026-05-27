# Bay Wheels Network Risk Monitoring

Anomaly detection on 12.6M bike share trips across 1,077 active stations in the Bay Area. The system flags single-day operational deviations and ties them back to weather events and city activity using only raw ride records.

## What this project demonstrates

- Loading and aggregating 12.6M rows in SQLite using materialized intermediate tables for sub-second query performance
- CTE chaining for layered analytical pipelines
- Manual statistical computation in SQL (variance from raw moments, since SQLite lacks STDDEV)
- Z-score anomaly detection on count data, including critical evaluation of when the method breaks
- Data quality discovery and handling (duplicate primary keys, schema migration, declared vs actual type mismatches)
- External data validation via NOAA weather table join

## The problem

A bike share system is a logistics network. Over 1,200 stations operate continuously, and any single one going silent for a day, surging in volume, or behaving unusually is an operational signal. A station dropping to near-zero rides on a normal weekday could be hardware failure, an upstream transit disruption, a weather event, or a city-wide event shifting traffic patterns elsewhere.

Monitoring 1,200 nodes manually does not scale. This project answers a focused question: can statistical anomaly detection on raw ride records surface real operational events without any labels or prior knowledge?

Yes. The system detected Folsom Street Fair, the 2021 atmospheric river, and Christmas Day commute drops across multiple stations from ride data alone.

## Data

- **Bay Wheels trips**: 12,617,387 records from May 2020 to December 2024. Source: Lyft public S3 bucket.
- **Station metadata**: 1,223 stations with coordinates. Source: Bay Wheels JSON feed.
- **NOAA GHCN-D weather**: Daily precipitation and temperature for SF airport, 2020 to 2024.

## Approach

### 1. Materialized aggregation table

Running daily ride counts per station against 12.6M raw rows on every query was prohibitively slow. The aggregation was pre-computed once into a ~1M row station-day table with indexes. Subsequent queries run in under 2 seconds.

```sql
CREATE TABLE station_daily_rides AS
SELECT 
    start_station_id AS station_id,
    SUBSTR(started_at, 1, 10) AS ride_date,
    COUNT(*) AS ride_count
FROM trips
WHERE start_station_id IS NOT NULL
GROUP BY start_station_id, SUBSTR(started_at, 1, 10);
```

`SUBSTR` was used instead of `DATE()` because the latter forces row-by-row date parsing and prevents the optimizer from using indexes on the timestamp column.

### 2. Per-station baseline statistics

For each station with at least 90 days of activity, mean and standard deviation of daily ride count were computed. SQLite has no `STDDEV()` function, so variance was derived from raw moments: `Var(X) = E[X²] - E[X]²`.

### 3. Z-score anomaly detection

For each station-day, the z-score `(observed - mean) / stddev` was computed. Station-days with `|z| > 2.5` were flagged as anomalies and categorized as SURGE or DROP based on sign.

### 4. External validation via weather join

Top-ranked anomaly dates were cross-referenced against NOAA daily weather records to distinguish weather-driven from event-driven anomalies.

## Findings

### Surges detected real city events

The highest-magnitude surges clustered on specific dates with clear external explanations:

- **September 28-29, 2024**: Four SoMa-area stations including SF-L24 (Folsom St at 13th St) showed z-scores between 7 and 11. This was Folsom Street Fair weekend, the last Sunday of September.
- **September 8, 2024**: Multiple San Jose stations including SJ-L7-1 (SAP Center) all surged simultaneously, indicating a major venue event.

### Drops detected weather and holidays

The highest-magnitude drops resolved cleanly into two categories:

- **October 24, 2021**: Three SF stations (Market St at Dolores, Hyde St at Post, Powell BART) crashed to 1-5 rides each with z-scores from -2.8 to -3.2. The weather table confirmed 102.1mm (4.02 inches) of rainfall that single day. This was San Francisco's record atmospheric river.
- **December 25, 2020 / December 25, 2021**: Multiple BART-adjacent stations dropped on Christmas Day. People are not commuting to transit hubs on federal holidays. This pattern validates the method against an obvious null hypothesis.

### Weather and anomaly correlation, quantified

| Date | Type | Rainfall (in) | Notes |
|---|---|---|---|
| 2021-10-23 | Pre-event | 0.82 | Storm building |
| 2021-10-24 | **DROP** | **4.02** | Atmospheric river, multi-station ridership crash |
| 2021-10-25 | Recovery | 0.31 | Storm passing |
| 2024-09-29 | **SURGE** | 0.00 | Bone dry, Folsom Street Fair |

The Folsom Street Fair surge happened on a completely dry day, confirming it was event-driven rather than weather-related. The October 2021 drops aligned exactly with the rainfall spike. Two distinct anomaly mechanisms, both validated externally.

## Methodology critique

The initial z-score implementation produced an unexpected result: every top anomaly was a SURGE and zero were DROPs. The cause is structural, not a bug.

For count data, the lower bound is zero. A station with mean=2 daily rides and stddev=1.8 can only drop to z = -1.1 (since ride_count cannot go below 0). The upper bound is unbounded. The z-score distribution on count data is asymmetric, especially for stations with low mean. This violates the Gaussian assumption that underlies standard z-score interpretation.

The fix was to filter the baseline to high-volume stations (mean >= 5 rides per day). At that threshold the Gaussian approximation is closer to valid and drops become detectable. The residual asymmetry is acknowledged as a methodological limitation.

For more rigorous treatment of count data, Poisson or negative-binomial models would be appropriate. Those were outside the scope of this project but are noted as future work.

## Data engineering notes

Several data quality issues surfaced during the work:

**Duplicate station IDs.** The stations metadata table contained multiple records per station_id (some IDs appearing 3-4 times with slightly different attributes). JOINs were inflating anomaly counts because each ride-day row was being duplicated by however many station matches it had. Resolved by aggregating station names with `MAX(station_name) ... GROUP BY station_id` to deduplicate pre-join.

**Declared type vs actual type.** The schema declared `trips.start_station_id` as REAL, but the actual values were strings like 'SF-E29-2'. SQLite's loose typing permits this divergence. An initial CAST-based join failed because casting 'SF-E29-2' to INTEGER produces nonsense. Direct text-on-text join works correctly.

**Schema migration before 2020-05.** Bay Wheels changed their CSV format around April 2020 (Lyft acquisition). Pre-migration data uses integer station IDs and different column names. The pre-migration files in the raw folder did not load into the current schema. Cohort begins May 2020 as a clean window.

## Limitations

- **Pre-COVID baseline is unavailable.** The dataset begins May 2020, so the March 2020 lockdown drop cannot be detected from this data. The depressed pandemic period IS the baseline.
- **Z-score is asymmetric on count data.** Filtering to high-volume stations mitigates but does not eliminate the bias. A Poisson-based detector would be more rigorous.
- **Single weather station.** NOAA SF airport observations only. Microclimates across the Bay Area are not captured.
- **No causal claim.** Anomalies are correlated with weather and events. Demonstrating causation would require controlled comparison or natural experiment design.

## Reproducing this work

```bash
git clone https://github.com/seojitongri/jun-kang-data-portfolio
cd jun-kang-data-portfolio/Bay-Wheels-SQL-Project

# Download raw monthly trip files (~470MB total)
# See 01_load_data.ipynb for the download script

# Build the database
jupyter notebook 01_load_data.ipynb

# Run any query
sqlite3 data/baywheels.db < queries/02_anomaly_drops.sql
```

## File structure

```
Bay-Wheels-SQL-Project/
├── README.md                          (this file)
├── 01_load_data.ipynb                 ETL from raw zip files to SQLite
├── data/
│   ├── baywheels.db                   ~3GB SQLite database (gitignored)
│   ├── weather_2018_2024.csv          NOAA weather data
│   └── raw/                           Monthly zip files (gitignored)
└── queries/
    ├── 01_baseline.sql                Per-station baseline statistics
    ├── 02_anomaly_drops.sql           Z-score drop detection
    ├── 03_anomaly_surges.sql          Z-score surge detection
    └── 04_weather_verification.sql    External validation via weather join
```

## Tech stack

SQLite | SQL (CTEs, materialized views, manual variance computation) | Python (pandas for ETL) | NOAA GHCN-D weather data

---

Built by Jun Kang. Statistics and Economics at UC Berkeley, graduating May 2026.
