FROM python:3.11

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN cd backend && python -c "from database import engine, Base; import models; Base.metadata.create_all(bind=engine)"

CMD cd backend && uvicorn main:app --host 0.0.0.0 --port $PORT
