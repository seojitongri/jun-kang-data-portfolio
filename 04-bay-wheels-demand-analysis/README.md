# Bay Wheels Demand Analysis: Weather-Driven Ridership Modeling

**Python | Pandas | Statsmodels | Matplotlib | Seaborn | NOAA API**

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/UCB-stat-159-f25/final-group15/main)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17970489.svg)](https://doi.org/10.5281/zenodo.17970489)

---

## The Question

Bay Wheels operates thousands of bikes across San Francisco with no real-time visibility into how many people will show up on any given day. Weather shifts demand fast — a rainy Tuesday morning looks nothing like a dry one. If operations teams could anticipate that, they could make smarter calls on fleet rebalancing, maintenance scheduling, and staffing.

This project builds a weather-driven demand model using 6 years of Bay Wheels trip data (2018–2024) merged with NOAA weather station observations from SF Downtown. The goal is to quantify how temperature and precipitation actually move ridership, and turn that into something operationally useful.

---

## Key Findings

**Temperature drives demand consistently.** Each additional 1°C in average daily temperature corresponds to roughly 250 more trips. Even within SF's narrow ~10–17°C range, warmer days show a meaningful lift.

**Rain hits hard.** On rainy days, ridership drops by an average of 1,480 trips compared to dry days with similar temperatures. That's about a 40% suppression relative to the typical weekday baseline. At higher precipitation levels (50+ mm), demand can fall by 70% or more.

**Day of week matters more than you'd think.** After controlling for weather, Tuesday through Thursday consistently outperform Sunday by 800–900 trips. Weekends run lower — likely a mix of fewer commuters and more recreational users who are more weather-sensitive.

**Seasonal peak is September–October.** Ridership climbs through spring and summer and tops out in early fall before dropping sharply in winter.

**COVID 2021 bucked the expected outdoor activity trend.** Despite assumptions that people would bike more during the pandemic, 2021 actually saw a ridership dip. The data suggests demand is more tied to commute patterns than recreational substitution.

---

## Modeling Approach

Three OLS specifications with HC1 heteroscedasticity-robust standard errors:

1. Baseline: temperature and precipitation only (R² ≈ 0.17)
2. With day-of-week controls (captures commute vs. weekend patterns)
3. Binary rain indicator instead of continuous precipitation (cleaner coefficient interpretation)

All three confirm temperature and rain as statistically significant predictors. Day-of-week controls don't change the weather coefficients much, which suggests the weather effect is real and not just picking up a weekday signal.

---

## Operational Implications

A simple weather forecast integration could give ops teams a same-day demand estimate:

- Heavy rain forecast → pre-position fewer bikes at low-ridership stations, front-load maintenance
- Warm dry weekday → expect peak demand, prioritize rebalancing toward high-traffic corridors

The model isn't production-ready (R² ≈ 0.17 leaves a lot unexplained), but it gives a useful directional signal that's better than no forecast at all.

---

## Repository Structure

```
02-bay-wheels-demand-analysis/
├── data/
│   ├── daily_stats.csv          # Bay Wheels trip records aggregated to daily level
│   ├── weather_2018_2024.csv    # NOAA SF Downtown station data (2018–2024)
│   └── USW00023272.csv          # Full historical station record
├── notebooks/
│   ├── 01-data-cleaning.ipynb   # ETL pipeline, merging, feature engineering
│   └── 02-visualization-analysis.ipynb  # EDA, regression models, visualizations
├── src/
│   └── data_utils.py            # Reusable data loading and cleaning functions
├── tests/
│   └── test_data_utils.py       # Unit tests for utility functions
├── environment.yml              # Conda environment — fully reproducible
├── Makefile                     # Run everything with `make all`
└── README.md
```

---

## Reproducibility

The full analysis runs in one command:

```bash
git clone https://github.com/seojitongri/jun-kang-data-portfolio.git
cd 02-bay-wheels-demand-analysis
conda env create -f environment.yml
conda activate notebook
make all
```

Or launch directly in Binder (no local setup needed): click the badge at the top.

The project is archived on Zenodo with a permanent DOI for citability.

---

## Data Sources

- **Bay Wheels trip data**: Lyft/Bay Wheels public trip records, 2018–2024
- **Weather data**: NOAA Global Historical Climatology Network, SF Downtown station (USW00023272)
