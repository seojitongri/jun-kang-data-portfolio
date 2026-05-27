# Jaguar Karaoke Business Analytics

**Jun Kang | UC Berkeley, Statistics & Economics**
*Independent Portfolio Project — March 2026*

---

## Business Problem

Jaguar Karaoke operates two private-room locations in Berkeley and Oakland, CA. Despite strong weekend demand, the business lacks structured analytics to answer basic operational questions:

- Why are weekend rooms consistently full while early evening slots sit empty across both locations?
- How does customer demand differ between Berkeley and Oakland, and should the two locations be managed differently?
- What data is currently not being collected that would unlock deeper revenue and retention analysis?
- Where is revenue being left on the table, and what specific changes would recover it?

This project analyzes reservation data to answer these questions and deliver actionable recommendations with direct revenue implications.

---

## What a Data Analyst Does for a Karaoke Business

A karaoke business hires a data analyst to help the owner fill more rooms, reduce slow hours, and understand customer behavior. The real-world assignment here was:

**"Analyze room booking data across two locations to identify why certain hours and days are underutilized, and recommend specific operational changes to increase occupancy and revenue per booking."**

The analyst's job is not just to look at numbers. It is to come back with findings like:
- Early evening slots (6-7PM) are consistently empty and represent recoverable revenue
- Oakland demand peaks earlier than Berkeley, suggesting different customer segments that need different strategies
- The current data system captures only a fraction of actual customer traffic, meaning every utilization metric is an underestimate

And then recommend:
- Targeted promotions for underutilized time windows
- Location-specific staffing and pricing strategies
- Specific data infrastructure improvements that would unlock customer segmentation, revenue analysis, and retention tracking

---

## Key Business Findings

**1. Revenue is concentrated in a narrow window — and early hours represent direct opportunity**

Reservation demand peaks sharply between 8PM and 11PM. Early evening slots from 6-7PM show near-zero utilization across both locations on most days. This is not a demand problem — it is a pricing and awareness problem. A targeted happy hour promotion or bundled package during 6-7PM could recover significant room-hours that are currently going empty.

**2. Oakland and Berkeley have fundamentally different customer bases that require different strategies**

Oakland peaks between 7-9PM with stronger reservation-based demand, suggesting older, more planned customer behavior — groups that book ahead, arrive early, and respond to confirmation reminders.

Berkeley peaks later around 10-11PM with weak reservation data, indicating heavy walk-in traffic from students and spontaneous groups. These customers cannot be reached through reservation-based promotions. They need in-person conversion tactics: visible pricing, bundle offers displayed at the front desk, and staff trained to upsell room upgrades.

**3. Reservation-only utilization (~7% Berkeley, ~13.5% Oakland) dramatically understates true demand**

Walk-in customers — who represent the majority of actual traffic, especially in Berkeley — are not captured in the current dataset. The real utilization rates are significantly higher. This means every business decision made from reservation data alone, including staffing, pricing, and inventory, is being made on incomplete information.

**4. The current data system is a bottleneck for growth**

The business cannot currently answer: Who are my repeat customers? What do customers order? Which promotions worked? How long do groups actually stay? These are standard questions for any revenue optimization effort, and none of them are answerable with current data. Fixing this is the highest-leverage improvement available.

---

## Revenue-Focused Recommendations

| Recommendation | Business Impact | Effort |
|---|---|---|
| Happy hour pricing 6-7PM | Recover empty early-evening room hours | Low |
| Extend peak staffing Fri/Sat 9-11PM | Reduce wait times, improve customer experience at highest-demand window | Low |
| Oakland: 24-48hr reservation confirmation | Reduce no-shows during early peak hours when impact is highest | Low |
| Implement walk-in tracking | Unlock true utilization data, enable real staffing and pricing decisions | Low |
| Introduce drink/room bundles | Increase revenue per booking, extend average session length | Medium |
| Restaurant partnership for F&B | Monetize existing customer behavior (outside food) without kitchen infrastructure | Medium |
| Improve daily operations data structure | Enable customer segmentation, retention analysis, and promotion tracking | Medium |
| Session ID system for extended stays | Link multi-row visits to the same customer, enabling accurate revenue-per-visit analysis | Low |

**Note:** These recommendations are graded by business priority, not data complexity. Jaguar's model intentionally prioritizes customer experience over revenue maximization — a deliberate strategic choice. Recommendations are designed to increase revenue without compromising the accessible, low-friction experience that drives loyalty.

---

## What This Analysis Could Not Answer — And What Data Would Fix It

This is where the analysis is honest about its limits, and where the biggest opportunities lie.

| Business Question | Why It Cannot Be Answered Now | Data Needed |
|---|---|---|
| Which customers are regulars? | No customer identifiers in reservation or daily data | Phone number or name as persistent ID |
| Do promotions work? | No promotion tracking in current system | Promotion flag column in daily sheet |
| What do customers order? | F&B recorded as single total, no item-level data | POS system or item-level receipt tracking |
| How long do groups actually stay? | Walk-ins not tracked, reservations often lack end times | Check-in/check-out timestamps for all customers |
| What is revenue per visit? | No linkage between extended-stay rows | Session ID at check-in |

Collecting this data would transform Jaguar from a business that reacts to demand into one that predicts and shapes it.

---

## Technical Approach

### The Data Challenge

Raw reservation data was entirely unstructured — all booking details including time, group size, and contact information were stored as free text in a single field. Example:

```
"9:30-11:30 8ppl Emily Murphy 925-594-9491"
```

Standard analysis tools cannot work with this format. The first technical challenge was making the data usable at all.

### What Was Built

**Custom parsing pipeline:** Regex-based extraction of start time, end time, group size, and phone number from unstructured text across 200+ reservation records from two locations with different formatting conventions.

**Business hour normalization:** Converted raw timestamps to a continuous business hour scale (6PM=18, midnight=24, 2AM=26) to handle overnight sessions correctly and calculate accurate session durations.

**Hourly utilization modeling:** Expanded each reservation into occupied hourly slots, aggregated by location and hour, and divided by total room capacity to produce true hourly utilization rates.

**Heatmap visualization:** Built a location-by-hour utilization heatmap showing average room occupancy at each hour across the full dataset — the clearest single visualization of when demand is high and when rooms are empty.

### Tech Stack

Python, Pandas, NumPy, Matplotlib, Seaborn, Regex

---

## Files

```
Jaguar Karaoke Business Analytics Project/
│
├── Jaguar_Analysis.ipynb          # Full analysis notebook
├── Reservation_Jaguar_March_Oakland.csv
├── Reservation_Jaguar_March_Berkeley.csv
└── README.md
```

---

## What I Would Do With More Data

With six months of reservation data plus daily operations sheets:
- Segment customers by group type, size, and visit frequency
- Identify which time slots and room types drive the highest revenue per hour
- Build a weekday demand model to test optimal happy hour pricing
- Quantify the revenue impact of no-shows by location and day of week
- Track whether specific promotions actually change booking behavior

This project demonstrates what is possible even with limited data. The bigger opportunity is building the data infrastructure to answer questions the business does not yet know how to ask.
