-- Query 2: Anomaly Detection - DROPS
-- Identifies station-days where ridership crashed >2.5 std below baseline.
-- Filtered to high-volume stations (mean >= 5 rides/day) to ensure
-- Gaussian z-score approximation is valid for count data.
--
-- Notable findings:
--   - 2021-10-24 cluster: SF atmospheric river (102mm/4 inches rain in one day)
--   - 2020-12-25, 2021-12-25: Christmas Day commute collapse (validates method)
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
SELECT 'DROP' AS anomaly_type, a.station_id, sn.station_name, a.ride_date, a.ride_count,
       ROUND(a.mean_daily_rides, 2) AS expected, ROUND(a.z_score, 2) AS z_score
FROM anomalies a LEFT JOIN station_names sn ON a.station_id = sn.station_id
WHERE a.z_score < -2.5
ORDER BY a.z_score ASC LIMIT 15;
