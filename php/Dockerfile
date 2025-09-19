FROM php:8.1-fpm-alpine

RUN apk update && apk add --no-cache \
    libzip-dev \
    zip \
    unzip \
    mariadb-connector-c-dev \
    && docker-php-ext-install pdo pdo_mysql zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apk add --no-cache shadow && \
    usermod -u 1000 www-data && \
    groupmod -g 1000 www-data

RUN mkdir -p /var/www/html/core/cache \
    /var/www/html/assets/cache \
    /var/www/html/core/export \
    /var/www/html/core/packages \
    /var/www/html/core/config

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chmod -R 777 /var/www/html/core/cache \
    /var/www/html/assets/cache \
    /var/www/html/core/config

WORKDIR /var/www/html