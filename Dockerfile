FROM cgr.dev/chainguard/python:latest-dev AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

FROM cgr.dev/chainguard/python:latest
WORKDIR /app

ENV PATH="/home/nonroot/.local/bin:$PATH"
ENV PYTHONPATH="/home/nonroot/.local/lib/python3.13/site-packages"

COPY --from=builder /home/nonroot/.local /home/nonroot/.local

COPY app.py .
COPY templates templates/
COPY static static/

ENTRYPOINT [ "flask", "run", "--host=0.0.0.0" ]