-- Query 3: Anomaly Detection - SURGES  
-- Identifies station-days where ridership spiked >2.5 std above baseline.
-- Filtered to high-volume stations (mean >= 5 rides/day).
--
-- Notable findings:
--   - 2024-09-28 to 2024-09-29 cluster: Folsom Street Fair (multiple SoMa stations)
--   - Single-day event signatures detectable from raw ride data alone
WITH station_baseline AS (
    SELECT
        station_id,
        AVG(ride_count) AS mean_daily_rides,
        SQRT(AVG(ride_count * ride_count) - AVG(ride_count) * AVG(ride_count)) AS stddev_daily_rides
    FROM station_daily_rides
    GROUP BY station_id
    HAVING COUNT(*) >= 90
       AND AVG(ride_count) >= 5
       AND SQRT(AVG(ride_count * ride_count) - AVG(ride_count) * AVG(ride_count)) > 0
),
station_names AS (
    SELECT station_id, MAX(station_name) AS station_name
    FROM stations
    GROUP BY station_id
),
anomalies AS (
    SELECT 
        sdr.station_id,
        sdr.ride_date,
        sdr.ride_count,
        sb.mean_daily_rides,
        (sdr.ride_count - sb.mean_daily_rides) / sb.stddev_daily_rides AS z_score
    FROM station_daily_rides sdr
    JOIN station_baseline sb ON sdr.station_id = sb.station_id
)
SELECT 'SURGE' AS anomaly_type, a.station_id, sn.station_name, a.ride_date, a.ride_count,
       ROUND(a.mean_daily_rides, 2) AS expected, ROUND(a.z_score, 2) AS z_score
FROM anomalies a LEFT JOIN station_names sn ON a.station_id = sn.station_id
WHERE a.z_score > 2.5
ORDER BY a.z_score DESC LIMIT 15;
