# To The Moon — Restaurant Revenue Analytics

**Live Dashboard:** [View on Tableau Public](https://public.tableau.com/app/profile/jun.kang1322/viz/ToTheMoon-RevenueDashboard/Dashboard1)

---

## Overview

Pro-bono analytics engagement with **To The Moon**, a Korean restaurant in Oakland, CA (4390 Telegraph Ave). The owner, Sungjin, purchased the restaurant in December 2025 and has been actively making operational improvements. This project analyzes how those changes affected revenue over the first four months of ownership.

This is both a genuine effort to support a small business owner and a portfolio demonstration of end-to-end analytics work — from raw POS data to stakeholder-ready visualization.

---

## Business Context

Sungjin is a first-time restaurant owner navigating a competitive Oakland dining market. His key strategic moves in the first four months:

| Date | Intervention |
|------|-------------|
| Mid-January 2026 | Lighting upgrade — brighter ambient lighting + neon "To The Moon" sign (~$1k investment) |
| March 27, 2026 | New plates and glassware |
| March 27, 2026 | Menu price increase (~10%) |
| March 27, 2026 | Delivery platform pricing increase (~30% on DoorDash/UberEats) |

**Strategic direction:** Pivoting from a Korean student customer base toward local non-Korean diners. Late-night hours (open until 2am) are a key differentiator.

---

## Data

Four months of monthly POS summary reports (December 2025 – March 2026), provided directly by the owner.

| Month | Revenue | Guests | Avg Spend | Drink % |
|-------|---------|--------|-----------|---------|
| Dec 2025 | $57,030 | 1,517 | $37.59 | 8.9% |
| Jan 2026 | $55,186 | 1,511 | $36.52 | 9.1% |
| Feb 2026 | $56,498 | 1,417 | $39.87 | 12.0% |
| Mar 2026 | $63,825 | 1,683 | $37.92 | 9.8% |

Revenue channels tracked: Dine-In, To-Go, DoorDash, UberEats.

---

## Key Findings

**Revenue trend:** Overall revenue grew 12% from the baseline period (Dec–Jan average) to March, reaching a four-month high of $63,825.

**Lighting upgrade effect:** February was the first full month after the lighting change. Drink revenue jumped from ~9% to 12% of total revenue — consistent with research showing that warmer, more vibrant ambiance increases bar sales. However, the industry benchmark for drink revenue is 20–25%, midpoint 22.5%, indicating significant upside still available.

**March interventions:** March saw the strongest revenue month, though three changes happened simultaneously (plates, menu price increase, delivery price increase), making it difficult to isolate which drove the result. This is a classic confounding problem in operational analytics — the kind that daily data will help untangle.

**Channel mix:** Dine-in revenue consistently represents ~70% of total revenue. Delivery (DoorDash + UberEats) accounts for ~25–27%, with DoorDash outperforming UberEats in every month.

**Avg spend stability:** Average spend per guest ($36–40) has been relatively stable despite the March price increase, suggesting demand held firm — a positive signal for further pricing power.

---

## Methodology

This project uses **interrupted time series analysis** — a quasi-experimental method for evaluating the impact of interventions when you cannot run a controlled experiment. Each operational change is treated as an interruption, and pre/post trends are compared.

With only 4 months of monthly data, the analysis is necessarily descriptive. The analytical centerpiece of this project will be rebuilt once daily data is available, enabling proper regression-based interrupted time series modeling.

---

## Dashboard

Built in **Tableau Public** with four views:

1. **Monthly Revenue** — line chart with vertical reference lines marking each intervention date
2. **Revenue by Channel** — stacked bar chart showing dine-in vs. to-go vs. DoorDash vs. UberEats mix per month
3. **Drink Revenue % vs. Industry Benchmark** — bar chart with 22.5% benchmark reference line
4. **KPI Cards** — total revenue, total guests, average spend, drink revenue %

---

## Tools

- **Python / pandas** — data cleaning and Excel file preparation
- **Tableau Public** — dashboard visualization
- **Excel** — structured data storage

---

## Next Steps

- Obtain daily POS data from Sungjin to enable granular time series modeling
- Measure ROI on Instagram ads and influencer partnerships (planned Q2 2026)
- Build regression model to isolate the effect of individual interventions
- Track drink revenue trend as primary KPI — closing the gap to the 20–25% industry benchmark is the highest-leverage opportunity identified

---

## About

Analytics project by **Jun Kang** — Statistics & Economics, UC Berkeley (May 2026).  
[LinkedIn](https://www.linkedin.com/in/junkang2002/) | [Tableau Public](https://public.tableau.com/app/profile/jun.kang1322)
