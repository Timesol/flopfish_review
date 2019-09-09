FROM python:3.6-alpine

RUN adduser -D flopfish

WORKDIR /home/flopfish

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install --upgrade pip
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn

COPY app app
COPY migrations migrations
COPY default0.py config.py boot.sh ./
RUN chmod +x boot.sh

ENV FLASK_APP default0.py

RUN chown -R flopfish:flopfish ./
USER flopfish

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]