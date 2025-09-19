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

WORKDIR /var/www/html
