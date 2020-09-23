FROM nginx:alpine

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="A FileRun docker image on Alpine Linux" \
      org.label-schema.description="A FileRun docker image on Alpine Linux." \
      org.label-schema.url="https://hub.docker.com/r/henryouly/filerun-alpine" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/henryouly/filerun-alpine" \
      org.label-schema.schema-version="1.0"

ENV FR_DB_HOST db
ENV FR_DB_PORT 3306
ENV FR_DB_NAME filerun
ENV FR_DB_USER filerun
ENV FR_DB_PASS filerun

RUN apk add --no-cache curl unzip

WORKDIR /srv

# Download FileRun installation package
RUN curl -sSL -o /srv/filerun.zip https://filerun.com/download-latest-php73
COPY autoconfig.php /srv/
COPY entrypoint.sh /docker-entrypoint.d/
COPY filerun.conf /etc/nginx/conf.d/default.conf

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1/fpm-ping
