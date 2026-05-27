# Jun Kang — Data Analytics Portfolio

**UC Berkeley, Statistics & Economics | May 2026**

[LinkedIn](https://www.linkedin.com/in/junkang2002/) | [Tableau Public](https://public.tableau.com/app/profile/jun.kang1322) | skyjun111@berkeley.edu

This portfolio is built on real business data from real owners making real decisions. The lead projects all began by approaching a business owner directly and proposing the analysis. The dataset wasn't downloaded from Kaggle. The problem wasn't assigned.

---

## Featured Projects

### 1. Bay Wheels Network Risk Monitoring
**`SQLite`** **`SQL (CTEs)`** **`Python`** **`NOAA Weather Data`**

Anomaly detection on 12.6M bike share trips across 1,077 active stations. The system flags single-day operational deviations and ties them back to weather events and city activity using raw ride records.

- Built a materialized aggregation layer reducing 12.6M raw rows to a 1M station-day table with indexes, enabling sub-second analytical queries across 1,077 stations
- Implemented z-score anomaly detection with manual variance computation in SQL (since SQLite lacks STDDEV), surfacing real city events without labels: Folsom Street Fair (Sept 28-29, 2024), the 2021 SF atmospheric river (Oct 24, 2021), and Christmas Day commute drops
- Documented methodology critique exposing z-score bias on count data with low means, then filtered baseline to validate the Gaussian assumption. Demonstrates statistical rigor beyond surface application.
- Cross-source validation via NOAA weather table confirmed 4.02-inch atmospheric river caused the multi-station drop, and a zero-rainfall day proved Folsom Street Fair surge was event-driven

[View Project →](01-bay-wheels-sql-network-monitoring/) | [View SQL Queries →](01-bay-wheels-sql-network-monitoring/queries/)

---

### 2. Jaguar Karaoke Business Analytics
**`Python`** **`Pandas`** **`Matplotlib`** **`Seaborn`**

Jaguar Karaoke runs two Bay Area locations with no formal data infrastructure. Reservations were tracked in a spreadsheet, walk-ins completely unrecorded. I work there part-time and proposed the analysis myself. Nobody asked me to.

- Built a custom regex parsing pipeline to extract start time, end time, group size, and contact info from unstructured free-text booking entries
- Engineered hourly utilization models revealing 52% peak room occupancy at Oakland vs 22% at Berkeley, driven by fundamentally different customer profiles at each location
- Identified that walk-in customers represent the majority of actual traffic, meaning reservation-only data significantly underestimates true demand
- Translated findings into prioritized operational recommendations aligned with the owner's goal of customer experience over revenue maximization

[View Project →](02-jaguar-karaoke-analytics/)

---

### 3. To The Moon Restaurant Analytics (Ongoing)
**`Python`** **`Pandas`** **`Tableau`** **`Interrupted Time Series`**

To The Moon is a Korean restaurant in Oakland's Temescal neighborhood. The owner, Sungjin, purchased it in December 2025 and has been actively investing in improvements: new lighting, new plates, menu price adjustments. I approached him cold, proposed the engagement, and he shared four months of POS revenue data.

- Analyzed monthly revenue across dine-in, to-go, DoorDash, and UberEats channels, identifying that dine-in drives ~70% of revenue while drink sales sit at ~10%, significantly below the 20-25% industry benchmark
- Applied interrupted time series framework to measure intervention effects. February (first full month after lighting upgrade) showed drink revenue jump from 9% to 12%, consistent with ambiance-driven bar sales research
- Built and published a Tableau Public dashboard with KPI cards, revenue trend line with intervention markers, channel mix breakdown, and drink revenue benchmarking against industry standard
- Engagement is ongoing. Next phase includes daily POS data for granular regression modeling and ROI measurement of Instagram ads and influencer campaigns

[View Dashboard →](https://public.tableau.com/app/profile/jun.kang1322) | [View Project →](03-to-the-moon-analytics/)

---

## Additional Projects

### Bay Wheels Demand Analysis: Weather Impact on Ridership
**`Python`** **`Pandas`** **`NOAA API`** **`Makefile`** **`Binder`**

Reproducible weather-driven demand modeling on 6 years of Bay Wheels trip data. This is the Python companion to the SQL Network Risk Monitoring project above, demonstrating ETL infrastructure and reproducibility tooling on the same dataset.

- Built an automated ETL pipeline merging 2018-2024 trip records with NOAA weather station data, processing millions of rows
- Engineered precipitation features and applied time-series analysis to quantify demand sensitivity. Heavy rain cuts ridership by approximately 1,500 trips. Extreme conditions suppress demand by up to 70%.
- Structured as a fully reproducible research project: modular `src/` library, automated Makefile pipeline, `environment.yml` for environment replication, and a Binder link so anyone can run the analysis in the cloud

[View Project →](04-bay-wheels-demand-analysis/)

---

### Subscription Growth Analytics
**`SQL`** **`Python`**

Growth metrics layer on a simulated subscription business. Built a full SQL pipeline for the core metrics tables (LTV, churn rate, CAC, cohort retention) then Python for analysis and visualization.

- Identified inefficiencies in acquisition channels and retention drop-offs across cohorts
- Designed reusable SQL queries for scalable metric tracking

[View Project →](05-subscription-growth-analytics/)

---

### Econometric Policy Analysis: Mariel Boatlift
**`Python`** **`Pandas`** **`Statsmodels`** **`R`** **`Stata`**

Replication of Card (1990) using U.S. CPS survey data to estimate the causal wage and employment effects of the 1980 Mariel Boatlift immigration shock.

- Built difference-in-differences regression models in Python and Stata, cleaned and merged large-scale multi-source survey data
- Applied OLS with dummy variable controls, communicated findings through regression tables and economic interpretation

[View Project →](06-mariel-boatlift-econometrics/)

---

## Skills

**Languages:** Python, SQL, R, Stata
**Libraries:** Pandas, NumPy, Statsmodels, Matplotlib, Seaborn
**Tools:** Excel (advanced), Tableau Public, Power BI, Jupyter, Git, Makefile, SQLite, DB Browser
**Concepts:** Business analytics, EDA, interrupted time series, z-score anomaly detection, causal inference, reproducible research, statistical SQL

## Contact

LinkedIn: [linkedin.com/in/junkang2002](https://www.linkedin.com/in/junkang2002/)
Tableau Public: [public.tableau.com/app/profile/jun.kang1322](https://public.tableau.com/app/profile/jun.kang1322)
Email: skyjun111@berkeley.edu
