# SFFD Service Calls Data Platform Implementation

## 🚀 Project Overview
This project establishes a robust, automated data platform on **Google Cloud Platform** for analyzing San Francisco Fire Department (SFFD) service calls. The solution transforms fragmented daily extracts into a high-performance analytics data mart.

## 🏗️ Architecture (Deliverable 1 & 2)
- **Ingestion:** GCS Landing Zone -> BigQuery Staging.
- **Transformation:** BigQuery SQL (ELT).
- **Modeling:** Star Schema (1 Fact, 2 Dimensions).
- **Automation:** Event-driven ingestion and Scheduled Query transformations.

## 🛠️ Data Engineering Features
- **Schema Resilience:** Explicitly handles data type drift in source files (Numeric vs. String) via casting in the ingestion layer.
- **Deduplication:** Implements an idempotent `ROW_NUMBER()` strategy to maintain a single "source of truth" for each incident.
- **Performance:** Optimized joins using `FARM_FINGERPRINT` integer surrogate keys instead of string-based joins.

## 📊 Analytics Model (Deliverable 4)
- **Fact Table:** `fact_service_calls` (Grain: 1 row per incident).
- **Dimensions:** `dim_location` (Neighborhoods), `dim_call_type` (Incident Categories).
- **KPIs:** Response Time (Seconds), Dispatch Delay, and Daily Activity Volume.

## ✅ Data Quality (Deliverable 5)
Continuous validation ensures:
- Zero duplicate `call_number` entries.
- 100% join coverage between Fact and Dimension layers.
- Validated performance metrics against raw benchmarks.
