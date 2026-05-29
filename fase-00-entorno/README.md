README del Proyecto 1 – Microservicio Observable
markdown
# Observable Microservice

[![CI](https://github.com/JereYlt/data-engineering-master/actions/workflows/ci.yml/badge.svg)](https://github.com/JereYlt/data-engineering-master/actions/workflows/ci.yml)
[![Python](https://img.shields.io/badge/Python-3.12-blue)](https://python.org)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.115-green)](https://fastapi.tiangolo.com)
[![Docker](https://img.shields.io/badge/Docker-24.0-blue)](https://docker.com)

A production‑ready REST API built with FastAPI that implements industry standards: structured JSON logging, correlated request IDs, rate limiting, automated tests, CI/CD, and a multi‑stage Docker build.

## Features

- **Structured logging** – JSON format, ready for log aggregation tools (Loki, Grafana)
- **Request correlation** – Each request gets a unique `X-Request-ID` header, propagated in all logs
- **Rate limiting** – Simple in‑memory limiter (max 10 requests per minute per IP)
- **Automated tests** – Pytest with coverage >80%
- **CI/CD pipeline** – GitHub Actions runs linters, type checks, tests, and Docker build on every push
- **Docker multi‑stage** – Small, secure production image (non‑root user)

## Technologies

| Tool | Purpose |
|------|---------|
| Python 3.12 | Core language |
| FastAPI | API framework |
| Uvicorn | ASGI server |
| Pydantic | Settings & data validation |
| Pytest | Testing |
| Ruff | Linting & formatting |
| MyPy | Static type checking |
| GitHub Actions | CI/CD |
| Docker | Containerisation |

## Quick start

### 1. Clone the repository
```bash
git clone https://github.com/JereYlt/data-engineering-master.git
cd data-engineering-master/fase-00-entorno
2. Configure environment variables
bash
cp .env.example .env
Edit .env if needed (defaults work for local development).

3. Create virtual environment and install dependencies
Linux / Mac:

bash
python3 -m venv venv
source venv/bin/activate
Windows (PowerShell):

bash
python -m venv venv
venv\Scripts\activate
Then:

bash
pip install -r requirements.txt
4. Run the API
bash
uvicorn app.main:app --reload
The API will be available at http://localhost:8000

5. Test the endpoints
bash
# Health check
curl http://localhost:8000/health

# Sum endpoint
curl "http://localhost:8000/suma?a=3&b=4"

# Interactive documentation
open http://localhost:8000/docs
Endpoints
Method	Endpoint	Description
GET	/health	Service health status
GET	/suma?a={n}&b={n}	Sum of two numbers
GET	/docs	Swagger UI (automatic)
GET	/redoc	ReDoc documentation
Running tests
bash
pytest --cov=app --cov-report=term-missing
Coverage must be at least 80% (CI will fail otherwise).

Docker
Build the image
bash
docker build -t microservicio-observable:latest .
Run the container
bash
docker run -p 8000:8000 microservicio-observable:latest
The API will be available at the same http://localhost:8000.

CI/CD with GitHub Actions
The .github/workflows/ci.yml pipeline runs on every push and pull request to main. It performs:

Ruff – linting and formatting checks

MyPy – static type checking

Pytest – unit tests with coverage (>80%)

Docker build – validates the Dockerfile

A green badge indicates a passing build.

Project structure
text
fase-00-entorno/
├── app/
│   ├── __init__.py
│   ├── config.py      # Pydantic settings (reads .env)
│   ├── main.py        # FastAPI app and endpoints
│   └── middleware.py  # Logging & rate limiting middleware
├── tests/
│   ├── __init__.py
│   └── test_main.py   # Pytest tests
├── .env.example       # Template for environment variables
├── .gitignore
├── Dockerfile
├── requirements.txt
└── README.md          # This file
Technical decisions
Decision	Why
JSON logging	Enables machine‑parsable logs – easy to search and filter with tools like Loki.
Request‑ID middleware	Correlates client errors with server logs; indispensable for debugging in production.
In‑memory rate limiting	Simple and sufficient for low‑concurrency scenarios; can be replaced with Redis for distributed deployment.
Multi‑stage Docker	Reduces final image size from ~1 GB to ~100 MB and improves security (non‑root user).
Pytest coverage threshold	Enforces 80% coverage – prevents untested code from reaching main.
Next steps
Add authentication (JWT) and caching (Redis) – see Project 4 (HR Datamart API).

Connect the API to a PostgreSQL database using SQLAlchemy – see Project 3 (FastAPI + SQLAlchemy).

License
MIT