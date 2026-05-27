# Project 2 – Professional Incremental ETL

## Description
This ETL pipeline extracts sales data from `pedidos` and `detalle_pedidos` tables, transforms it (calculates subtotals, filters completed orders), and loads it into a fact table `hechos_ventas`. The process is **incremental** (only new records), **idempotent** (no duplicates if run twice), and includes full **audit logging** (`etl_control`, `etl_log`).

## Technologies
- PostgreSQL 16
- PL/pgSQL (stored procedures, functions)
- Indexes for query optimization

## File Structure
| File | Purpose |
|------|---------|
| `01_modelo_datos.sql` | Creates fact table `hechos_ventas`, control table `etl_control`, and log table `etl_log`. |
| `02_function_descuento.sql` | Auxiliary function to calculate discount based on order total. |
| `03_etl_procedure.sql` | Main ETL stored procedure (`etl_cargar_ventas`). |
| `04_queries_analiticas.sql` | Three analytical queries: weekly sales, top 5 products, RFM analysis. |
| `capturas/` | Screenshots showing execution results, log entries, and performance improvements. |

## How to Run

### 1. Prepare the environment (PostgreSQL must be running)
```bash
cd fase-00-entorno
docker-compose up -d