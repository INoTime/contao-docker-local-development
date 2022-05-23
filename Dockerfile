FROM php:7.4-apache

RUN a2enmod rewrite
RUN a2enmod ssl

RUN apt-get update
RUN apt-get install -y libzip-dev git wget --no-install-recommends
RUN apt-get install -y libicu-dev
RUN apt-get install -y libpng-dev
RUN apt-get install -y curl
RUN apt-get install -y gcc make libssh2-1-dev libssh2-1

RUN docker-php-ext-install intl
RUN docker-php-ext-install gd
RUN docker-php-ext-install pdo mysqli pdo_mysql zip;
RUN curl http://pecl.php.net/get/ssh2-1.2.tgz -o ssh2.tgz && \
    pecl install ssh2 ssh2.tgz && \
    docker-php-ext-enable ssh2 && \
    rm -rf ssh2.

RUN wget https://getcomposer.org/download/2.0.9/composer.phar
RUN mv composer.phar /usr/bin/composer
RUN chmod +x /usr/bin/composer

WORKDIR /var/www/html
RUN mkdir contao

RUN COMPOSER_MEMORY_LIMIT=-1 composer create-project contao/managed-edition:4.9 /var/www/html/contao

COPY Contao/composer.json contao
COPY Contao/web/contao-manager.phar.php contao/web

RUN chown www-data:www-data contao -R

COPY docker/etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY docker/etc/apache2/apache2.conf /etc/apache2/apache2.conf
COPY docker/usr/local/etc/php/php.ini /usr/local/etc/php

RUN openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj \
    "/C=DE/ST=None/L=None/O=INoInvestigation/OU=IT/CN=localhost" -keyout ./ssl.key -out ./ssl.crt
RUN mkdir /etc/apache2/ssl
RUN cp ./ssl.key /etc/apache2/ssl/ssl.key
RUN rm ./ssl.key
RUN cp ./ssl.crt /etc/apache2/ssl/ssl.crt
RUN rm ./ssl.crt

CMD ["apache2-foreground"]

EXPOSE 80 80
EXPOSE 443 443
