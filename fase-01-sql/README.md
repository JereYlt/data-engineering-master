# Proyecto 2 – ETL Incremental Profesional

## Descripción
Pipeline ETL que carga datos de ventas desde `pedidos` y `detalle_pedidos` hacia una tabla de hechos (`hechos_ventas`). El proceso es **incremental** (solo registros nuevos), **idempotente** (no duplica al ejecutarse varias veces) y cuenta con **auditoría completa** (`etl_control` y `etl_log`).

## Tecnologías
- PostgreSQL 16
- PL/pgSQL (stored procedures)

## Estructura de archivos
- `01_modelo_datos.sql` – creación de tablas (hechos_ventas, etl_control, etl_log)
- `02_function_descuento.sql` – función auxiliar para calcular descuento
- `03_etl_procedure.sql` – procedimiento ETL principal
- `04_queries_analiticas.sql` – tres consultas analíticas sobre hechos_ventas
- `capturas/` – evidencia de ejecución (pantallazos)

## Cómo ejecutar
1. Asegúrate de que PostgreSQL esté corriendo (Docker).
2. Conéctate a la base de datos `cursodb`.
3. Ejecuta los archivos en orden:
   ```bash
   psql -U admin -d cursodb -f 01_modelo_datos.sql
   psql -U admin -d cursodb -f 02_function_descuento.sql
   psql -U admin -d cursodb -f 03_etl_procedure.sql