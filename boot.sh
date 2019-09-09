#!/bin/sh
source venv/bin/activate
exec gunicorn -b 10.146.177.50:5000 --access-logfile - --error-logfile - default0:app
