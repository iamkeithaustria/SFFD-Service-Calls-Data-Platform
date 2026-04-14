# SFFD Service Calls Data Platform

## 1. Project Overview
This repository contains the technical implementation of a cloud-based data platform for the San Francisco Fire Department (SFFD) service call datasets. The solution addresses the end-to-end data lifecycle: from raw daily extracts to an analytics-ready dimensional model.

## 2. Architecture Design (Deliverable 1)
The platform is built on **Google Cloud Platform (GCP)**, leveraging a modern ELT (Extract, Load, Transform) architecture.

*   **Ingestion Layer:** Google Cloud Storage (GCS) serves as the landing zone. Automated ingestion is triggered by file arrival notifications.
*   **Transformation Layer:** BigQuery serves as the compute engine for data cleaning, deduplication, and modeling.
*   **Analytics Layer:** A Star Schema data mart designed for high-performance reporting.

## 3. Data Ingestion & Exchange (Deliverable 2)
*   **Location:** `gs://sffd-daily-extracts/` (Google Cloud Storage)
*   **Mechanism:** Event-driven architecture. A Cloud Function monitors the bucket and triggers a BigQuery Load Job upon file finalization, ensuring **zero manual intervention**.

## 4. Data Pipeline (Deliverable 3)
The pipeline handles two primary technical challenges:
1.  **Schema Consistency:** Explicit `CAST` logic is implemented to standardize inconsistent data types (e.g., `fire_prevention_district`) across daily extracts.
2.  **Deduplication:** Implemented using a `QUALIFY ROW_NUMBER()` window function to ensure idempotency—only the latest record version is promoted to the analytics layer.

## 5. Analytics Data Model (Deliverable 4)
The data is modeled into a **Star Schema** to support rapid analysis of response times and call volumes.

### Tables:
*   **`fact_service_calls`**: Central metrics table (Grain: 1 row per unique service call).
*   **`dim_location`**: Geographic dimensions (Neighborhood, Zipcode).
*   **`dim_call_type`**: Service call categorization (Type, Group).

### Key Performance Indicators (KPIs):
*   **Response Time:** Time from call received to unit on-scene.
*   **Call Volume:** Daily aggregation of service requests.

## 6. Documentation (Deliverable 5)
Detailed SQL scripts for the implementation are located in the `/sql` directory:
*   `01_raw_ingestion.sql`: Consolidates and fixes daily extracts.
*   `02_star_schema.sql`: Builds the dimensional model.
*   `03_quality_checks.sql`: Validates record counts and data integrity.

## 7. Quality Strategy
Validation checks are performed at the end of each pipeline run:
*   **Completeness:** Checks for NULLs in critical columns.
*   **Uniqueness:** Validates that the Fact table contains zero duplicate `call_number` entries.
*   **Accuracy:** Sample calculation of average response times against raw source benchmarks.
