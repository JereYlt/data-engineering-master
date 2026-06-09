# Project 3 – dbt Data Mart for e‑commerce

This project transforms raw data from a PostgreSQL e‑commerce database (`tienda` schema) into a **production‑ready data mart** using dbt (Data Build Tool). The data mart includes analytical tables and views: weekly/monthly sales, customer summary, top products, and RFM segmentation.

---

## Features

- **4‑layer architecture**: Sources → Staging → Intermediate → Marts
- **Automated tests**: `not_null`, `unique`, `accepted_values`, `relationships`
- **Full documentation**: Auto‑generated lineage graph and column descriptions
- **Idempotent and incremental** (where needed) models
- **Local PostgreSQL** (development) and ready to run on **BigQuery** (production)

---

## Prerequisites

- Docker with PostgreSQL 16 (`curso_postgres` container)
- dbt Core installed in a virtual environment (see [dbt installation guide](https://docs.getdbt.com/docs/core/installation))
- Git

---

## Setup

### 1. Clone the repository and navigate to the dbt project

```bash
git clone https://github.com/JereYlt/data-engineering-master.git
cd data-engineering-master/tienda_dbt