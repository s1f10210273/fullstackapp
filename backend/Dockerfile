FROM python:3.11
WORKDIR /backend
RUN python -m venv venv
COPY requirements.txt ./
RUN . venv/bin/activate && pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["/bin/bash", "-c", ". venv/bin/activate && python manage.py runserver 0.0.0.0:8000"]
