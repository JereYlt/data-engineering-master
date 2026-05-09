
---

## 📄 `README.pt.md` (portugués) – ya con JereYlt

```markdown
# 🚀 Roteiro de Engenheiro de Dados e IA

[![ES](https://img.shields.io/badge/Español-README.es-red)](README.es.md)
[![PT](https://img.shields.io/badge/Português-README.pt-brightgreen)](README.pt.md)
[![EN](https://img.shields.io/badge/English-README-blue)](README.md)
[![CI](https://github.com/JereYlt/data-engineering-master/actions/workflows/ci.yml/badge.svg)](https://github.com/JereYlt/data-engineering-master/actions/workflows/ci.yml)
[![Python](https://img.shields.io/badge/Python-3.12-blue)](https://python.org)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.115-green)](https://fastapi.tiangolo.com)

Roteiro profissional do zero ao nível Sênior em **Engenharia de Dados + Engenharia de ML + Engenharia de IA + Backend Python**.

## 🌟 Características

- **40 semanas**, 20–25h/semana
- **19 projetos de portfólio** (código pronto para produção)
- **Stack completo e moderno**: Docker, PostgreSQL, dbt, FastAPI, Kafka, Airflow, XGBoost, PyTorch, MLOps, RAG, Kubernetes, Terraform
- **CI/CD**, testes de carga, observabilidade, segurança, IaC

## 📂 Fases e projetos

| Fase | Conteúdo | Projeto |
|------|----------|---------|
| 00 | Ambiente + Python produção | Microsserviço observável |
| 01 | SQL avançado + ETL | ETL incremental com PL/pgSQL |
| 02 | dbt + SQL na nuvem | Data mart com dbt (PostgreSQL + BigQuery) |
| 03 | APIs + testes de carga | API RH (FastAPI + Redis + Locust) |
| 04 | Engenharia de dados com Python | Pipeline multi‑fonte (Polars + Parquet + GCS) |
| 05 | Kafka + Schema Registry | Pipeline orientado a eventos (Avro + DLQ + replay) |
| 06 | Airflow + dbt | DAG diário com alertas no Slack |
| 07 | ML clássico (XGBoost + SHAP) | Modelo de churn com explicabilidade total |
| 08 | Deep Learning (PyTorch + LoRA) | Fine‑tuning de BERT + servidor ONNX |
| 09 | MLOps em produção | Feast + MLflow + canary + drift + rollback |
| 10 | RAG + Agentes (LangGraph) | Assistente de RH com memória e avaliação RAGAS |
| 11 | K8s + Terraform + PySpark | Infraestrutura como código + dados em escala |
| 12 | Observabilidade + CI/CD | Prometheus + Grafana + Jaeger + Loki + Helm |
| 13 | Integrador final | DataPlatform Master (end‑to‑end) |

## 🛠️ Stack tecnológico

| Camada | Ferramentas |
|--------|-------------|
| Bancos de dados | PostgreSQL, pgvector, BigQuery |
| Transformação | dbt, Polars, PySpark |
| Mensageria | Kafka + Schema Registry (Avro) |
| Orquestação | Airflow |
| API Backend | FastAPI, JWT, Redis, SQLAlchemy |
| ML e LLMs | XGBoost, SHAP, PyTorch, HuggingFace, LoRA, ONNX, LangGraph |
| MLOps | Feast, MLflow, Evidently |
| IaC e K8s | Terraform, Kubernetes (kind), Helm |
| Observabilidade | Prometheus, Grafana, Jaeger, Loki |
| CI/CD | GitHub Actions, Trivy, Locust |

## 🚀 Início rápido (Fase 00 – Ambiente)

```bash
# Clonar o repositório
git clone https://github.com/JereYlt/data-engineering-master.git
cd data-engineering-master/fase-00-entorno

# Copiar variáveis de ambiente
cp .env.example .env

# Subir PostgreSQL + pgAdmin
docker-compose up -d

# Acessar o banco de dados em localhost:5432
# Interface pgAdmin: http://localhost:5050 (admin@curso.com / admin123)