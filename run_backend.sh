#!/usr/bin/env bash
# One-step backend start: install deps, migrate, create admin (first time), run server
set -e
pip install -r requirements.txt
python manage.py migrate
python manage.py createsuperuser || true
python manage.py runserver
