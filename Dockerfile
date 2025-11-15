FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Создаем базу данных при запуске
RUN cd backend && python -c "from database import engine, Base; import models; Base.metadata.create_all(bind=engine)"

# Запускаем приложение
CMD cd backend && uvicorn main:app --host 0.0.0.0 --port 8080
