FROM php:7.4-apache

RUN a2enmod rewrite

RUN apt-get update
RUN apt-get install -y libzip-dev git wget --no-install-recommends
RUN apt-get install -y libicu-dev
RUN apt-get install -y libpng-dev
RUN apt-get install -y curl

RUN docker-php-ext-install intl
RUN docker-php-ext-install gd
RUN docker-php-ext-install pdo mysqli pdo_mysql zip;

RUN wget https://getcomposer.org/download/2.0.9/composer.phar
RUN mv composer.phar /usr/bin/composer
RUN chmod +x /usr/bin/composer

WORKDIR /var/www/html
RUN mkdir contao

RUN COMPOSER_MEMORY_LIMIT=-1 composer create-project contao/managed-edition:4.9 /var/www/html/contao

COPY Contao/composer.json contao
COPY Contao/web/contao-manager.phar.php contao/web

COPY docker/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY docker/apache2.conf /etc/apache2/apache2.conf

RUN chown www-data:www-data contao -R

CMD ["apache2-foreground"]

EXPOSE 80 8080
