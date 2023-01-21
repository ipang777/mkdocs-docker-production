FROM squidfunk/mkdocs-material:latest as docs

# Build-time flags
ARG WITH_PLUGINS=true

# Environment variables
ENV PACKAGES=/usr/local/lib/python3.11/site-packages
ENV PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

COPY . /app

RUN ["mkdocs", "build"]

FROM nginx:latest as webserver

EXPOSE 80

COPY --from=docs /app/site /usr/share/nginx/html