# Bay Wheels Demand Analysis

Weather Impact on Daily Ridership

## Business Question

How does daily weather impact bike rental demand, and how can this inform operational planning decisions such as fleet allocation and maintenance scheduling?

## Data

* Daily Bay Wheels trip counts (2018 to 2024)
* Daily weather data including precipitation and temperature
* Data merged at the daily level

## My Contribution

* Designed repository structure for reproducibility
* Built environment.yml and Binder deployment
* Implemented testing framework
* Created helper functions for data processing
* Structured main narrative notebook
* Ensured full reproducibility from raw data to final PDF report

## Analytical Approach

1. Aggregated trip data to daily level
2. Engineered precipitation categories (Dry, Light, Moderate, Heavy, Extreme)
3. Computed average daily trips by precipitation level
4. Visualized trends across years
5. Quantified magnitude of demand change due to rainfall

## Key Findings

* Dry days average approximately 7000 trips
* Heavy rain reduces demand by roughly 1500 trips per day
* Extreme precipitation can reduce demand by over 70 percent
* Weather effects are consistent across multiple years

## Business Implications

* Forecast based fleet rebalancing
* Maintenance scheduling during low demand weather days
* Staffing adjustments aligned with expected demand
* Incorporating weather variables into demand forecasting models

## Tools

Python

Pandas

Matplotlib

Reproducible research workflows
