FROM python:3.8.5-slim

USER root

RUN mkdir /app
WORKDIR /app
ADD ./app/ .
RUN pip install -r requirements.txt

EXPOSE 5000

USER 1000

CMD ["python", "-u", "/app/main.py"]