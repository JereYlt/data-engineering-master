
---

## 📄 `README.es.md` (español) – ya con JereYlt

```markdown
# 🚀 Backend · Datos · IA – Portafolio Profesional

[![ES](https://img.shields.io/badge/Español-README.es-red)](README.es.md)
[![PT](https://img.shields.io/badge/Português-README.pt-brightgreen)](README.pt.md)
[![EN](https://img.shields.io/badge/English-README-blue)](README.md)
[![CI](https://github.com/JereYlt/data-engineering-master/actions/workflows/ci.yml/badge.svg)](https://github.com/JereYlt/data-engineering-master/actions/workflows/ci.yml)
[![Python](https://img.shields.io/badge/Python-3.12-blue)](https://python.org)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.115-green)](https://fastapi.tiangolo.com)

Roadmap profesional desde cero hasta Senior en **Ingeniería de Datos + Ingeniería ML + Ingeniería IA + Backend Python**.

## 🌟 Características

- **40 semanas**, 20–25h/semana
- **19 proyectos de portafolio** (código listo para producción)
- **Stack completo moderno**: Docker, PostgreSQL, dbt, FastAPI, Kafka, Airflow, XGBoost, PyTorch, MLOps, RAG, Kubernetes, Terraform
- **CI/CD**, pruebas de carga, observabilidad, seguridad, IaC

## 📂 Fases y proyectos

| Fase | Contenido | Proyecto |
|------|-----------|----------|
| 00 | Entorno + Python producción | Microservicio observable |
| 01 | SQL avanzado + ETL | ETL incremental con PL/pgSQL |
| 02 | dbt + SQL en la nube | Data mart con dbt (PostgreSQL + BigQuery) |
| 03 | APIs + pruebas de carga | API RH (FastAPI + Redis + Locust) |
| 04 | Ingeniería de datos con Python | Pipeline multi‑fuente (Polars + Parquet + GCS) |
| 05 | Kafka + Schema Registry | Pipeline event‑driven (Avro + DLQ + replay) |
| 06 | Airflow + dbt | DAG diario con alertas en Slack |
| 07 | ML clásico (XGBoost + SHAP) | Modelo de churn con explicabilidad total |
| 08 | Deep Learning (PyTorch + LoRA) | Fine‑tuning de BERT + servicio ONNX |
| 09 | MLOps de producción | Feast + MLflow + canary + drift + rollback |
| 10 | RAG + Agentes (LangGraph) | Asistente de RRHH con memoria y evaluación RAGAS |
| 11 | K8s + Terraform + PySpark | Infraestructura como código + datos a escala |
| 12 | Observabilidad + CI/CD | Prometheus + Grafana + Jaeger + Loki + Helm |
| 13 | Integrador final | DataPlatform Master (end‑to‑end) |

## 🛠️ Stack tecnológico

| Capa | Herramientas |
|------|--------------|
| Bases de datos | PostgreSQL, pgvector, BigQuery |
| Transformación | dbt, Polars, PySpark |
| Mensajería | Kafka + Schema Registry (Avro) |
| Orquestación | Airflow |
| API Backend | FastAPI, JWT, Redis, SQLAlchemy |
| ML y LLMs | XGBoost, SHAP, PyTorch, HuggingFace, LoRA, ONNX, LangGraph |
| MLOps | Feast, MLflow, Evidently |
| IaC y K8s | Terraform, Kubernetes (kind), Helm |
| Observabilidad | Prometheus, Grafana, Jaeger, Loki |
| CI/CD | GitHub Actions, Trivy, Locust |

## 🚀 Inicio rápido (Fase 00 – Entorno)

```bash
# Clonar el repositorio
git clone https://github.com/JereYlt/data-engineering-master.git
cd data-engineering-master/fase-00-entorno

# Copiar variables de entorno
cp .env.example .env

# Levantar PostgreSQL + pgAdmin
docker-compose up -d

# Acceder a la base de datos en localhost:5432
# Interfaz pgAdmin: http://localhost:5050 (admin@curso.com / admin123)