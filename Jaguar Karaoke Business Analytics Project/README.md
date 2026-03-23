## Note: This project is actively being refined. Additional data pipelines, visualizations, and modularization are in progress.

# Jaguar Karaoke Business Analytics

## Executive Summary

This project analyzes reservation data from a two-location karaoke business (Berkeley and Oakland) to understand customer demand patterns, capacity utilization, and operational inefficiencies.

Key findings include:

* Peak demand consistently occurs between **8 PM and 10 PM** across both locations
* The **Oakland location exhibits stronger reservation-based demand**, reaching over 50% utilization during peak hours
* The **Berkeley location appears significantly underutilized** based on reservation data alone
* Early hours (before 7 PM) show **systematic underutilization across both locations**

Business implications:

* There is clear opportunity to increase utilization through **targeted promotions and pricing strategies**
* Current reservation data **underrepresents total demand**, particularly due to walk-in customers
* Different operational strategies are needed for each location

---

## Problem Statement

The business currently lacks structured analytics to answer key operational questions:

* When is customer demand highest?
* Are rooms being utilized efficiently throughout the day?
* How do demand patterns differ between locations?
* Where are the biggest opportunities to increase revenue or improve customer experience?

This project transforms raw reservation logs into actionable insights to support data-driven decision making.

---

## Data Description

The dataset consists of reservation-level records from Jaguar Karaoke, including:

* Reservation date and time
* Duration of booking
* Location (Berkeley or Oakland)
* Room usage

### Data Challenges

* Raw data was **unstructured and required extensive cleaning**
* **Walk-in customers are not captured**, leading to underestimation of true utilization
* No direct revenue or item-level sales data available

---

## Methodology

### 1. Data Cleaning

* Parsed raw reservation logs into structured tabular format
* Standardized time formats and extracted usable datetime features

### 2. Feature Engineering

* Reservation duration (hours)
* Hourly occupancy
* Location-based segmentation
* **Utilization rate = occupied rooms / total capacity**

### 3. Analysis

* Aggregated reservation counts by hour and location
* Constructed hourly utilization matrix
* Visualized patterns using heatmaps

---

## Key Results

### Average Hourly Utilization (Reservation-Based)

* **Oakland peaks at ~50% utilization during 9 PM–10 PM**
* **Berkeley remains below ~25% utilization across most hours**
* Early hours (4 PM–7 PM) show **consistently low demand**

These values represent **reservation-based utilization only**, and actual usage is likely higher due to walk-ins.

---

## Key Insights

### 1. Strong Evening Demand Concentration

Customer activity is heavily concentrated in late evening hours, indicating a narrow peak window.

### 2. Location-Based Differences

* Oakland shows stronger structured (reservation) demand
* Berkeley likely relies more heavily on walk-in customers

### 3. Underutilized Capacity

Both locations exhibit significant unused capacity, especially during early hours.

### 4. Data Limitations Matter

Reservation data alone does not capture the full picture, highlighting the need for improved tracking systems.

---

## Business Recommendations

### Short-Term Actions

* Introduce **early-hour promotions (happy hour pricing, discounts)**
* Offer **group incentives to shift demand earlier**
* Test **weekday-specific deals** to increase traffic

### Medium-Term Improvements

* Implement **better tracking for walk-in customers**
* Track **room-level usage and turnover time**
* Improve reservation system consistency

### Long-Term Strategy

* Explore **dynamic pricing during peak hours**
* Align pricing strategy with owner’s goal of maintaining a **fun and accessible experience**, not purely revenue maximization

---

## Tech Stack

* Python (Pandas, NumPy)
* Data Visualization (Matplotlib, Seaborn)
* Jupyter Notebook

---

## Project Structure

```
jaguar-karaoke-business-analytics/
│
├── notebooks/
│   ├── data_cleaning.ipynb
│   ├── analysis.ipynb
│
├── data/
│   ├── raw/
│   ├── cleaned/
│
├── outputs/
│   ├── figures/
│
├── src/
│   ├── utils.py
│
└── README.md
```

---

## Limitations & Future Work

* Incorporate **walk-in customer data** for more accurate utilization estimates
* Integrate **revenue and item-level sales data** for profitability analysis
* Develop **predictive models** for demand forecasting
* Explore **causal impact of promotions or pricing changes**

---

## Takeaway

This project demonstrates how even incomplete operational data can be transformed into actionable insights. By combining data cleaning, feature engineering, and business-oriented analysis, it highlights opportunities to improve both **efficiency and customer experience** in a real-world setting.

