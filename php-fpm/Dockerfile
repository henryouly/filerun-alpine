FROM php:7.3-fpm-alpine

RUN apk add --no-cache curl \
                       freetype-dev \
                       libjpeg-turbo-dev \
                       libzip-dev \
                       openldap-dev \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure ldap \
    && docker-php-ext-install -j$(nproc) pdo_mysql exif zip gd opcache ldap

WORKDIR /tmp

# Install ionCube
RUN PHP_EXT_DIR=$(php-config --extension-dir) \
 && curl -sSL http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_armv7l.tar.gz \
  | tar -xz --strip-components=1 -C $PHP_EXT_DIR ioncube/ioncube_loader_lin_7.3.so \
 && echo "zend_extension=ioncube_loader_lin_7.3.so" >> /usr/local/etc/php/conf.d/00_ioncube_loader_lin_7.3.ini

COPY filerun-optimization.ini /usr/local/etc/php/conf.d/
