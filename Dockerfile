FROM python:3.6-alpine

RUN adduser -D flopfish

WORKDIR /home/flopfish

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN apk add --update alpine-sdk
RUN apk add --no-cache libressl-dev musl-dev libffi-dev
RUN venv/bin/pip install --upgrade pip
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn pymysql supervisor nginx
RUN sudo rm /etc/nginx/sites-enabled/default

COPY nginx_conf /etc/nginx/sites-enabled/nginx_conf

COPY app app
COPY migrations migrations
COPY default0.py config.py boot.sh ./
RUN chmod +x boot.sh

ENV FLASK_APP default0.py

RUN chown -R flopfish:flopfish ./
USER flopfish

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]