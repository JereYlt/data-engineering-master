# 🚀 Backend · Data · AI – Portfolio Profesional Roadmap

[![ES](https://img.shields.io/badge/Español-README.es-red)](README.es.md)
[![PT](https://img.shields.io/badge/Português-README.pt-brightgreen)](README.pt.md)
[![EN](https://img.shields.io/badge/English-README-blue)](README.md)
[![CI](https://github.com/JereYlt/data-engineering-master/actions/workflows/ci.yml/badge.svg)](https://github.com/JereYlt/data-engineering-master/actions/workflows/ci.yml)
[![Python](https://img.shields.io/badge/Python-3.12-blue)](https://python.org)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.115-green)](https://fastapi.tiangolo.com)

Professional roadmap from zero to Senior in **Data Engineering + ML Engineering + AI Engineering + Backend Python**.

## 🌟 Features

 
- **19 portfolio projects** (real production code)
- **Full modern stack**: Docker, PostgreSQL, dbt, FastAPI, Kafka, Airflow, XGBoost, PyTorch, MLOps, RAG, Kubernetes, Terraform
- **CI/CD**, load testing, observability, security, IaC

## 📂 Phases & Projects

| Phase | Content | Project |
|-------|---------|---------|
| 00 | Environment + Python production | Observable microservice |
| 01 | Advanced SQL + ETL | Incremental ETL with PL/pgSQL |
| 02 | dbt + Cloud SQL | Data mart with dbt (PostgreSQL + BigQuery) |
| 03 | APIs + load testing | HR Datamart API (FastAPI + Redis + Locust) |
| 04 | Data engineering with Python | Multi‑source pipeline (Polars + Parquet + GCS) |
| 05 | Kafka + Schema Registry | Event‑driven pipeline (Avro + DLQ + replay) |
| 06 | Airflow + dbt | Daily DAG with Slack alerts |
| 07 | Classical ML (XGBoost + SHAP) | Churn model with full explainability |
| 08 | Deep Learning (PyTorch + LoRA) | BERT fine‑tuning + ONNX serving |
| 09 | Production MLOps | Feast + MLflow + canary + drift + rollback |
| 10 | RAG + Agents (LangGraph) | HR assistant with memory and RAGAS evaluation |
| 11 | K8s + Terraform + PySpark | Infrastructure as Code + big data processing |
| 12 | Observability + CI/CD | Prometheus + Grafana + Jaeger + Loki + Helm |
| 13 | Final integrator | DataPlatform Master (end‑to‑end) |

## 🛠️ Technology Stack

| Layer | Tools |
|-------|-------|
| Databases | PostgreSQL, pgvector, BigQuery |
| Data transformation | dbt, Polars, PySpark |
| Message broker | Kafka + Schema Registry (Avro) |
| Orchestration | Airflow |
| Backend API | FastAPI, JWT, Redis, SQLAlchemy |
| ML & LLMs | XGBoost, SHAP, PyTorch, HuggingFace, LoRA, ONNX, LangGraph |
| MLOps | Feast, MLflow, Evidently |
| IaC & K8s | Terraform, Kubernetes (kind), Helm |
| Observability | Prometheus, Grafana, Jaeger, Loki |
| CI/CD | GitHub Actions, Trivy, Locust |

## 🚀 Quick start (Phase 00 – Environment)

```bash
# Clone the repository
git clone https://github.com/JereYlt/data-engineering-master.git
cd data-engineering-master/fase-00-entorno

# Copy environment variables
cp .env.example .env

# Start PostgreSQL + pgAdmin
docker-compose up -d

# Access the database at localhost:5432
# pgAdmin UI: http://localhost:5050 (admin@curso.com / admin123)