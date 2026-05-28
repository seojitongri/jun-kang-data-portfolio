-- Query 5: Per-Station Weather Sensitivity
-- Quantifies how much each station's ridership responds to precipitation.
-- Stations are categorized by how much rain suppresses their demand.
--
-- Key design decisions:
--   - "Rainy" = PRCP > 50 (5mm in NOAA tenths-mm format) -- meaningful rain, not drizzle
--   - "Clear"  = PRCP = 0 -- no precipitation at all
--   - Minimum sample filters: 10 rainy days, 20 clear days, 50 total paired days
--     to ensure statistical reliability before computing sensitivity
--   - NULLIF guards against division-by-zero on inactive stations
--   - lat/lng included to sanity-check geographic patterns (waterfront/exposed
--     stations expected to show higher sensitivity than sheltered downtown nodes)
--
-- Why this matters:
--   Weather-sensitive stations (commuter routes, exposed plazas) show demand
--   drop > 30% on rainy days. Weather-resistant stations (transit hubs,
--   covered areas) hold demand regardless. This distinction is operationally
--   useful for rebalancing and staffing decisions.

WITH station_meta AS (
    -- Deduplicate stations table (known duplicate station_ids)
    SELECT station_id,
           MAX(station_name) AS station_name,
           AVG(lat)          AS lat,
           AVG(lng)          AS lng
    FROM stations
    GROUP BY station_id
),

station_weather_summary AS (
    SELECT
        sdr.station_id,
        m.station_name,
        m.lat,
        m.lng,
        COUNT(*)                                                         AS paired_days,
        SUM(sdr.ride_count)                                             AS total_rides,
        COUNT(CASE WHEN w.PRCP = 0   THEN 1 END)                        AS clear_days,
        AVG(CASE  WHEN w.PRCP = 0   THEN CAST(sdr.ride_count AS REAL) END) AS avg_rides_clear,
        COUNT(CASE WHEN w.PRCP > 50  THEN 1 END)                        AS rainy_days,
        AVG(CASE  WHEN w.PRCP > 50  THEN CAST(sdr.ride_count AS REAL) END) AS avg_rides_rainy,
        AVG(CAST(sdr.ride_count AS REAL))                               AS avg_rides_overall
    FROM station_daily_rides sdr
    INNER JOIN weather w
        ON sdr.ride_date = w.DATE
    LEFT JOIN station_meta m
        ON sdr.station_id = m.station_id
    GROUP BY sdr.station_id
    HAVING
        paired_days >= 50
        AND clear_days >= 20
        AND rainy_days >= 10
),

station_sensitivity AS (
    SELECT
        station_id,
        station_name,
        lat,
        lng,
        paired_days,
        clear_days,
        rainy_days,
        ROUND(avg_rides_clear,   1)  AS avg_rides_clear,
        ROUND(avg_rides_rainy,   1)  AS avg_rides_rainy,
        ROUND(avg_rides_overall, 1)  AS avg_rides_overall,
        ROUND(
            (avg_rides_rainy - avg_rides_clear)
            / NULLIF(avg_rides_clear, 0) * 100,
        1)                           AS weather_sensitivity_pct
    FROM station_weather_summary
    WHERE avg_rides_clear > 0
),

categorized AS (
    SELECT
        *,
        CASE
            WHEN weather_sensitivity_pct < -30  THEN 'High sensitivity (>30% drop)'
            WHEN weather_sensitivity_pct < -15  THEN 'Medium sensitivity (15-30% drop)'
            WHEN weather_sensitivity_pct <   0  THEN 'Low sensitivity (<15% drop)'
            ELSE                                     'Weather resistant (no drop)'
        END AS weather_category
    FROM station_sensitivity
)

SELECT
    station_name,
    avg_rides_clear,
    avg_rides_rainy,
    weather_sensitivity_pct AS pct_change,
    weather_category,
    ROUND(lat, 4) AS lat,
    ROUND(lng, 4) AS lng,
    clear_days,
    rainy_days
FROM categorized
ORDER BY weather_sensitivity_pct ASC
LIMIT 15;
