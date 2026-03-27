# Jun Kang — Data Analytics Portfolio

UC Berkeley, Statistics & Economics | Graduating May 2026  
[LinkedIn](https://www.linkedin.com/in/junkang2002/) | skyjun111@berkeley.edu

This portfolio highlights data analytics projects using Python, SQL, and statistical modeling, focused on turning messy real-world data into decisions that actually matter to the people running the business.

---

## Projects

### 1. Jaguar Karaoke Business Analytics (Real-World)
`Python` `Pandas` `Matplotlib` `Seaborn`

Jaguar Karaoke runs two Bay Area locations with no formal data infrastructure — reservations tracked in a spreadsheet, walk-ins unrecorded. I worked directly with the owner to analyze 200+ reservation records and build the first structured view of how the business actually operates.

- Built a custom regex parsing pipeline to extract start time, end time, group size, and contact info from free-text booking entries
- Engineered hourly utilization models revealing 52% peak room occupancy at Oakland vs 22% at Berkeley, driven by fundamentally different customer profiles at each location
- Identified that walk-in customers represent the majority of actual traffic, meaning reservation-only data significantly underestimates true demand
- Translated findings into prioritized operational recommendations aligned with the owner's goal of customer experience over revenue maximization

[View Project →](https://github.com/seojitongri/jun-kang-data-portfolio/tree/main/Jaguar%20Karaoke%20Business%20Analytics%20Project)

---

### 2. Bay Wheels Demand Analysis: Weather Impact on Ridership
`Python` `Pandas` `Matplotlib` `Seaborn` `NOAA API` `Makefile` `Binder`

Bay Wheels operates thousands of bikes across the Bay Area with no built-in visibility into how weather will shift demand on a given day. This project builds a reproducible weather-driven demand model to quantify that relationship and support fleet rebalancing and maintenance scheduling decisions.

- Built an automated ETL pipeline merging 6 years of Bay Wheels trip records (2018–2024) with NOAA weather station data, processing millions of rows
- Engineered precipitation and weather condition features, applied time-series analysis to quantify demand sensitivity — heavy rain cuts ridership by roughly 1,500 trips, extreme conditions suppress demand by up to 70%
- Structured as a fully reproducible research project: modular `src/` library, automated `Makefile` pipeline, `environment.yml` for environment replication, and a Binder link so anyone can run the analysis in the cloud

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/UCB-stat-159-f25/final-group15/main)

[View Project →](https://github.com/seojitongri/jun-kang-data-portfolio/tree/main/02-bay-wheels-demand-analysis)

---

### 3. Subscription Growth Analytics
`SQL` `Python`

Built a full growth metrics layer on a simulated subscription business — wrote SQL to construct the core metrics tables (LTV, churn rate, CAC, cohort retention), then Python for analysis and visualization.

- Identified inefficiencies in acquisition channels and retention drop-offs across cohorts
- Designed reusable SQL queries for scalable metric tracking

[View Project →](https://github.com/seojitongri/jun-kang-data-portfolio/tree/main/01-subscription-growth-analytics)

---

### 4. Econometric Policy Analysis — Mariel Boatlift
`Python` `Pandas` `Statsmodels`

Replicated Card (1990) using U.S. CPS survey data to estimate the causal wage and employment effects of the 1980 Mariel Boatlift immigration shock.

- Built difference-in-differences regression models in Python (statsmodels), cleaned and merged large-scale multi-source survey data
- Applied OLS with dummy variable controls, communicated findings through regression tables and economic interpretation

[View Project →](https://github.com/seojitongri/jun-kang-data-portfolio/tree/main/02-econometrics-mariel-boatlift)

---

## Skills

**Languages:** Python, SQL, R  
**Libraries:** Pandas, NumPy, Statsmodels, Matplotlib, Seaborn  
**Tools:** Excel (advanced), Tableau, Power BI, Jupyter, Git, Makefile  
**Concepts:** Business analytics, EDA, statistical modeling, causal inference, reproducible research

---

## Contact

LinkedIn: https://www.linkedin.com/in/junkang2002/  
Email: skyjun111@berkeley.edu
