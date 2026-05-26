-- Query 1: Per-station ridership baseline
-- Establishes "normal" daily usage per station as foundation for anomaly detection
-- Uses materialized station_daily_rides table (created from trips aggregation)
SELECT 
    sdr.station_id,
    MAX(s.station_name) AS station_name,
    ROUND(AVG(sdr.ride_count), 2) AS mean_daily_rides,
    ROUND(SQRT(AVG(sdr.ride_count * sdr.ride_count) - AVG(sdr.ride_count) * AVG(sdr.ride_count)), 2) AS stddev_daily_rides,
    COUNT(DISTINCT sdr.ride_date) AS active_days,
    MIN(sdr.ride_date) AS first_active,
    MAX(sdr.ride_date) AS last_active
FROM station_daily_rides sdr
LEFT JOIN stations s ON sdr.station_id = s.station_id
GROUP BY sdr.station_id
HAVING COUNT(DISTINCT sdr.ride_date) >= 30
ORDER BY mean_daily_rides DESC
LIMIT 20;
