FROM ubuntu:22.04

RUN apt-get update -y && apt-get install -y python3 python3-pip && rm -rf /var/lib/apt/lists/*

RUN pip3 install flask

WORKDIR /opt
COPY app.py .

EXPOSE 18080
ENTRYPOINT ["flask", "run", "--host=0.0.0.0", "--port=18080"]
ENV FLASK_APP=app.py
