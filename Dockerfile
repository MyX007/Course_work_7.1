FROM python:3.10

WORKDIR /myapp

COPY requirements.txt ./
RUN apt-get update \
    && apt-get install -y gcc libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV CELERY_BROKER_URL='redis://localhost:6379/0'
ENV CELERY_BACKEND='redis://localhost:6379/0'
ENV DATABASE_URL=postgres://postgres:112233@host:2255/Docker
ENV SECRET_KEY=django-insecure-rt4@$e0j=orc&=v=39fu2aw6r6ey7r4=ntx46sev5zts^l=93y
ENV DEBUG=False

RUN mkdir -p /media

EXPOSE 8000

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]