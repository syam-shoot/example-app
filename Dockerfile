FROM php:7.4-fpm

# Set working directory
WORKDIR /var/www

# Install system dependencies and PHP extensions
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        curl \
        libpng-dev \
        libonig-dev \
        libxml2-dev \
        zip \
        unzip \
    && docker-php-ext-install \
        pdo_mysql \
        mbstring \
        exif \
        pcntl \
        bcmath \
        gd \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Get specific version of Composer
COPY --from=composer:2.1.3 /usr/bin/composer /usr/bin/composer

# # Create system user to run Composer and Artisan Commands
# ARG sammy
# ARG 1001
# RUN useradd -G www-data,root -u $uid -d /home/$user $user \
#     && mkdir -p /home/$user/.composer \
#     && chown -R $user:$user /home/$user

# USER $user
