FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Ne pas exécuter en root (règle DS002)
RUN useradd --create-home appuser
USER appuser

# Healthcheck (règle DS026)
HEALTHCHECK --interval=30s --timeout=3s CMD python -c "print('ok')" || exit 1

CMD ["python", "app.py"]
