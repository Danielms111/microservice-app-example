FROM python:3.6-slim

WORKDIR /app
COPY . .

ENV REDIS_HOST=redis
ENV REDIS_PORT=6379
ENV REDIS_CHANNEL=log_channel

RUN pip install -r requirements.txt

CMD ["python3", "main.py"]
