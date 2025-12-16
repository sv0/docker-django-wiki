FROM python:alpine3.20
LABEL org.opencontainers.image.authors="Slavik Svyrydiuk <slavik@svyrydiuk.eu>"
EXPOSE 8000
ARG VERSION="0.12.0"


WORKDIR /app
RUN pip3 \
    --no-cache-dir install \
    --root-user-action ignore \
    --disable-pip-version-check \
        wiki==${VERSION} \
        gunicorn==23.0.0

COPY app /app
COPY entrypoint.sh /

RUN mkdir -p data && \
    python3 manage.py migrate && \
    python3 manage.py collectstatic --no-input

ENTRYPOINT '/entrypoint.sh'
