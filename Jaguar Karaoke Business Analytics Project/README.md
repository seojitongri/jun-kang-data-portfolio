# Jaguar Karaoke Business Analytics

**Jun Kang | UC Berkeley, Statistics & Economics**  
*Independent Portfolio Project — March 2026*

---

## Executive Summary

This project analyzes reservation data from Jaguar Karaoke, a private-room karaoke business with two Bay Area locations (Berkeley and Oakland), to identify demand patterns, capacity inefficiencies, and actionable operational improvements.

**Key findings:**
- Peak reservation demand occurs between **8PM–11PM**, with Oakland peaking earlier (7–9PM) and Berkeley later (9–11PM)
- Oakland reaches **~52% room utilization** at peak hours based on reservation data alone
- Berkeley shows low reservation-based utilization (~22% max), consistent with its **walk-in driven model**
- Early evening slots (6–7PM) are **systematically underutilized** across both locations
- Reservation data significantly **underestimates true demand** — walk-in customers represent the majority of actual traffic, especially in Berkeley

---

## Problem Statement

The business lacked structured analytics to answer key operational questions:
- When is customer demand highest, and does it differ by location?
- How efficiently are rooms being utilized throughout the day?
- Where are the biggest opportunities to improve revenue or customer experience?
- What improvements to data collection would unlock deeper analysis?

---

## Data

Raw reservation logs from March 2026 across two locations:

| Feature | Description |
|---|---|
| Date | Reservation date |
| Check-in text | Unstructured field containing time, group size, contact info |
| Room | Room number assigned |
| Confirmed | Whether reservation was confirmed |
| Location | Berkeley or Oakland |

**Data challenges:**
- All reservation details (time, group size, phone) stored as unstructured text in a single field — required custom parsing
- Walk-in customers not captured, leading to underestimation of true utilization
- No item-level F&B data or customer identifiers available

---

## Methodology

### 1. Data Cleaning
- Loaded and merged Berkeley and Oakland datasets with standardized schema
- Forward-filled missing dates, removed rows without check-in times
- Parsed unstructured text fields using regex to extract start time, end time, group size, and phone number

### 2. Feature Engineering
- Converted raw times into a continuous business hour scale (6PM = 18, midnight = 24, 2AM = 26) to handle overnight sessions
- Calculated session duration, hourly occupancy slots, and weekday
- Computed utilization rate = booked hours / total capacity hours

### 3. Analysis
- Reservation counts by hour and location
- Room utilization rate by location
- Average hourly utilization heatmap
- Group size and session duration behavior analysis

---

## Key Results

### Peak Hour Demand
Demand is heavily concentrated between 8PM–11PM. Oakland shows stronger early evening demand while Berkeley peaks later, likely reflecting its student-driven customer base.

### Capacity Utilization
| Location | Utilization Rate (reservation-based) |
|---|---|
| Berkeley | ~7% |
| Oakland | ~13.5% |

These are conservative estimates. Walk-in traffic — untracked in the current dataset — significantly raises actual utilization, particularly in Berkeley.

### Hourly Heatmap
Oakland reaches ~52% reservation-based occupancy at 9PM. Berkeley remains below ~22% across all hours, consistent with its walk-in model rather than a true demand gap.

### Reservation Behavior
- Sessions cluster tightly around **2–3 hours**, aligning with standard pricing
- Early evening reservations skew toward larger, pre-planned groups
- Reservation data is biased toward larger parties — smaller walk-in groups are not represented

---

## Recommendations

| Recommendation | Effort | Impact | Priority |
|---|---|---|---|
| Extend peak hour staffing (Fri/Sat 9–11PM) | Low | High | High |
| Early evening incentives (Happy Hour 6–7PM) | Medium | High | High |
| Improve daily operations data structure | Medium | Very High | High |
| Oakland reservation confirmation (24–48hr prior) | Low | Medium | Medium |
| Drink-driven revenue stream (bundles, happy hour) | Medium | High | High |
| Restaurant partnership for F&B | Low | Medium | Medium |
| Ancillary revenue options (optional drink packages) | Medium | Medium | Medium |

**Note on business strategy:** These recommendations are framed as optional improvements. Jaguar's current model intentionally prioritizes customer experience over revenue maximization — a deliberate strategic choice that likely drives long-term loyalty over short-term profit.

For full recommendation details see the [analysis notebook](./Jaguar_Analysis.ipynb).

---

## Data Limitations & Improvement Opportunities

**Current limitations:**
- No-shows tracked via cell color only — not exportable or analyzable
- No customer identifiers, revenue data, or item-level purchases
- Berkeley and Oakland used different formats requiring significant preprocessing

**Recommended improvements:**
1. **Session continuity tracking** — assign a session ID (e.g. room + check-in time like "R5-2030") to link extension rows to the original visit
2. **Item-level F&B tracking** — current daily sheet records F&B as a single total; a simple POS or tablet system would capture product-level data without adding staff burden
3. **Standardize reservation schema** — separate start time, end time, group size, and contact into distinct fields
4. **Add explicit no-show column** — replace color-based encoding with a binary flag
5. **Capture revenue per reservation** — enables pricing analysis and customer value tracking

---

## Tech Stack

- **Python** — Pandas, NumPy, Matplotlib, Seaborn
- **Key technique** — Custom regex parsing pipeline to extract structured data from unstructured reservation text
- **Jupyter Notebook**

---

## Files

```
Jaguar Karaoke Business Analytics Project/
│
├── Jaguar_Analysis.ipynb   # Full analysis notebook
├── Reservation_Jaguar_March_Oakland.csv    # Raw reservation data (Oakland)
├── Reservation_Jaguar_March_Berkeley.csv   # Raw reservation data (Berkeley)
└── README.md
```
