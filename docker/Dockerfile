FROM library/php:8.1-apache

RUN apt update && apt install -y curl zlib1g-dev libpq-dev git libicu-dev libxml2-dev libzip-dev libpng-dev acl \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-install mysqli pdo pdo_mysql \ 
    && docker-php-ext-enable pdo_mysql \
    && docker-php-ext-install zip xml

RUN curl --insecure https://getcomposer.org/composer.phar -o /usr/bin/composer && chmod +x /usr/bin/composer

COPY /php/dev/uploads.ini /usr/local/etc/php/conf.d/uploads.ini

WORKDIR /var/www/html