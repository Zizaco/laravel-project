FROM php:5.6-apache

# Install modules
RUN apt-get update && apt-get install -y \
        git \
        php5-dev \
        libmcrypt-dev \
    && docker-php-ext-install mcrypt mbstring zip pdo_mysql

# Install composer
RUN curl -sS https://getcomposer.org/installer \
        | php -- --install-dir=/usr/local/bin \
        && mv /usr/local/bin/composer.phar /usr/local/bin/composer

# Configure apache
RUN sed -i "s/DocumentRoot .*/DocumentRoot \/var\/www\/html\/public/" /etc/apache2/apache2.conf
RUN echo "error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT" >> /usr/local/etc/php/conf.d/error.ini
RUN echo "log_errors = On" >> /usr/local/etc/php/conf.d/error.ini
RUN a2enmod rewrite

# Install node
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash
RUN . ~/.nvm/nvm.sh && nvm install 0.12.2 \
    && ln -s /bin/versions/node/v0.12.2/bin/node /usr/bin/node \
    && ln -s /bin/versions/node/v0.12.2/bin/npm /usr/bin/npm

# Install libpng
RUN apt-get install -y libpng-dev libjpeg-dev zlib1g-dev

# Install gulp & bower
RUN npm install --global gulp; npm install --global bower

# Set storage to writable
COPY . /var/www/html/
RUN chmod -R 777 storage/
