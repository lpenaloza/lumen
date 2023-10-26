FROM php:8.2-fpm

# Set COMPOSER_ALLOW_SUPERUSER environment variable
ENV COMPOSER_ALLOW_SUPERUSER=1

# Install PDO for MySQL
# RUN apt-get update && apt-get install -y default-mysql-client

# Install dependencies for PDO
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zlib1g-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql


# Install nginx, git, unzip
RUN apt-get update && apt-get install -y nginx unzip

# Add composer
RUN curl -sS https://getcomposer.org/installer | php && \
    chmod +x composer.phar && \
    mv composer.phar /usr/local/bin/composer


# Install supervisor
RUN apt-get install -y supervisor

# Configure nginx
COPY docker/container/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY docker/container/fpm-pool.conf /etc/php8/php-fpm.d/www.conf
COPY docker/container/php.ini /etc/php8/conf.d/custom.ini

# Configure supervisord and entrypoint
COPY docker/container/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker/container/entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Change owner of /var/www to www-data
RUN chown -R www-data:www-data /var/www

#COPY docker/bin/start.sh /devops/start.sh
#RUN chmod 755 /devops/start.sh

# Add application
WORKDIR /var/www
COPY api/ /var/www/


# Install composer dependencies
# RUN composer install --prefer-dist --no-dev


# Expose the port nginx is reachable on
#EXPOSE 80

# CMD /devops/start.sh
# Entrypoint script starts supervisord
# Use it for any processing during container launch
# Example generate .env file from a secrets manager
ENTRYPOINT ["/entrypoint.sh"]





#FROM php:8.1-fpm-alpine
#
## Install packages and remove default server definition
#RUN apt --no-cache add \
#  curl \
#  nginx \
#  php8 \
#  php8-ctype \
#  php8-curl \
#  php8-dom \
#  php8-fpm \
#  php8-gd \
#  php8-intl \
#  php8-json \
#  php8-mbstring \
#  php8-mysqli \
#  php8-opcache \
#  php8-openssl \
#  php8-phar \
#  php8-session \
#  php8-xml \
#  php8-xmlreader \
#  php8-zlib \
#  php8-redis \
#  php8-xmlwriter \
#  php8-tokenizer \
#  php8-pdo \
#  php8-pdo_mysql \
#
## Create symlink so programs depending on `php` still function
#RUN ln -s /usr/bin/php8 /usr/bin/php
#
## Add composer
#RUN curl -sS https://getcomposer.org/installer | php && \
#    chmod +x composer.phar && \
#    mv composer.phar /usr/local/bin/composer
#
## Configure nginx
#COPY docker/container/nginx.conf /etc/nginx/nginx.conf
#
## Configure PHP-FPM
#COPY docker/container/fpm-pool.conf /etc/php8/php-fpm.d/www.conf
#COPY docker/container/php.ini /etc/php8/conf.d/custom.ini
#
## Configure supervisord and entrypoint
#COPY docker/container/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#COPY docker/container/entrypoint.sh /entrypoint.sh
#
## Add application
#WORKDIR /var/www
##COPY api/ /var/www/
#
## Install composer dependencies
#RUN composer install --prefer-dist --no-dev
#
## Expose the port nginx is reachable on
#EXPOSE 80
#
## Entrypoint script starts supervisord
## Use it for any processing during container launch
## Example generate .env file from a secrets manager
#ENTRYPOINT ["/entrypoint.sh"]



#
## Use the official PHP image with Apache as a base
#FROM php:8.1-apache
#
#
## Install system dependencies and PHP extensions
#RUN apt-get update && apt-get install -y  \
#    libfreetype6-dev \
#    libjpeg-dev \
#    libpng-dev \
#    libwebp-dev \
#    --no-install-recommends \
#    libzip-dev \
#    unzip \
#    && docker-php-ext-enable opcache \
#    && docker-php-ext-configure gd --with-freetype --with-jpeg \
#    && docker-php-ext-install pdo_mysql -j$(nproc) gd \
#    && apt-get autoclean -y \
#    && rm -rf /var/lib/apt/lists/*
#
## Install Composer globally
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#
## Update apache conf to point to application public directory
#ENV APACHE_DOCUMENT_ROOT=/var/www/public
#RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
#RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
#
## Update uploads config
#RUN echo "file_uploads = On\n" \
#         "memory_limit = 1024M\n" \
#         "upload_max_filesize = 512M\n" \
#         "post_max_size = 512M\n" \
#         "max_execution_time = 1200\n" \
#         > /usr/local/etc/php/conf.d/uploads.ini
#
## Enable headers module
#RUN a2enmod rewrite headers
#
#COPY docker/bin/start.sh /devops/start.sh
#
#RUN chmod 755 /devops/start.sh
#
## Copy your Lumen/Laravel application files
#COPY /api /var/www/html
#WORKDIR /var/www/html
#
## Install Laravel or Lumen
#WORKDIR /var/www/html
#
#
## Expose ports
#EXPOSE 80 443
#
#
#CMD /devops/start.sh
