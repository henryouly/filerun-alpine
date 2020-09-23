FROM php:7.3-fpm-alpine

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="A FileRun docker image on Alpine Linux." \
      org.label-schema.description="A FileRun docker image on Alpine Linux. This is the php-fpm module." \
      org.label-schema.url="https://hub.docker.com/r/henryouly/filerun-alpine-php-fpm" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/henryouly/filerun-alpine" \
      org.label-schema.vendor="FileRun" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

RUN apk add --no-cache --virtual .build-deps curl \
                       freetype-dev \
                       libjpeg-turbo-dev \
                       libzip-dev \
                       openldap-dev \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure ldap \
    && docker-php-ext-install -j$(nproc) pdo_mysql exif zip gd opcache ldap \
    && PHP_EXT_DIR=$(php-config --extension-dir) \
    && curl -sSL http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_armv7l.tar.gz \
     | tar -xz --strip-components=1 -C $PHP_EXT_DIR ioncube/ioncube_loader_lin_7.3.so \
    && echo "zend_extension=ioncube_loader_lin_7.3.so" >> /usr/local/etc/php/conf.d/00_ioncube_loader_lin_7.3.ini \
    && apk del .build-deps

# set recommended PHP.ini settings
# see http://docs.filerun.com/php_configuration
COPY filerun-optimization.ini /usr/local/etc/php/conf.d/
COPY www.conf /usr/local/etc/php-fpm.d/
