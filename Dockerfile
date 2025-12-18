FROM python:3.10-slim

WORKDIR /app

COPY flask_app/ /app/
COPY models/vectorizer.pkl /app/models/vectorizer.pkl

RUN pip install --upgrade pip && \
    pip install --no-cache-dir --default-timeout=120 mlflow==2.19.0

# Upgrade pip + increase timeout
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --default-timeout=120 -r requirements.txt

RUN python -m nltk.downloader stopwords wordnet

EXPOSE 5000

CMD ["python", "app.py"]

#Prod
# CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--timeout", "120", "app:app"]