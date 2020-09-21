FROM nginx:alpine

# add PHP, extensions and third-party software
RUN apk add --no-cache curl unzip

WORKDIR /srv

# Download FileRun installation package
RUN curl -sS -o /srv/filerun.zip -L https://filerun.com/download-latest-php73
COPY autoconfig.php /srv/
COPY entrypoint.sh /docker-entrypoint.d/
COPY filerun.conf /etc/nginx/conf.d/default.conf

ENV FR_DB_HOST db
ENV FR_DB_PORT 3306
ENV FR_DB_NAME filerun
ENV FR_DB_USER filerun
ENV FR_DB_PASS filerun
