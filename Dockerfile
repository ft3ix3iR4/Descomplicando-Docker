# FROM cgr.dev/chainguard/python:latest-dev 
# WORKDIR /app
# COPY requirements.txt .
# RUN pip install --user --no-cache-dir -r requirements.txt

# COPY app.py .
# COPY templates templates/
# COPY static static/

# ENTRYPOINT [ "flask", "run", "--host=0.0.0.0" ]

FROM cgr.dev/chainguard/python:latest-dev as buildando
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

FROM cgr.dev/chainguard/python:latest
WORKDIR /app

COPY --from=buildando /home/nonroot/.local /home/nonroot/.local

COPY app.py .
COPY templates templates/
COPY static static/

# ENTRYPOINT [ "flask", "run", "--host=0.0.0.0" ]
ENTRYPOINT ["/home/nonroot/.local/bin/flask", "run", "--host=0.0.0.0"]