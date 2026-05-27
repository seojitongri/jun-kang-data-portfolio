-- Query 4: Weather verification for detected anomalies
-- Cross-references anomaly dates against weather table (NOAA GHCN format).
-- PRCP unit: tenths of mm. So PRCP=1021 means 102.1mm = 4.02 inches rainfall.
-- TMAX/TMIN unit: tenths of degrees Celsius.
--
-- Validates that:
--   - 2021-10-24 drops correlate with 4-inch rainstorm (atmospheric river)
--   - 2024-09-29 surges occurred on dry day (event-driven, not weather)
SELECT DATE, 
       ROUND(PRCP / 10.0, 2) AS rainfall_mm,
       ROUND(PRCP / 254.0, 2) AS rainfall_inches,
       ROUND(TMAX / 10.0, 1) AS max_temp_c,
       ROUND(TMIN / 10.0, 1) AS min_temp_c
FROM weather
WHERE DATE IN ('2021-10-23', '2021-10-24', '2021-10-25',
               '2024-09-28', '2024-09-29',
               '2020-12-25', '2021-12-25')
ORDER BY DATE;
