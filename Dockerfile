# Użyj oficjalnego obrazu PHP 8.2-FPM jako obrazu bazowego
FROM php:8.2-fpm

# Zainstaluj zależności systemowe
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    nodejs \
    npm

# Wyczyść cache apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Zainstaluj rozszerzenia PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Zainstaluj Composera
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Ustaw katalog roboczy
WORKDIR /var/www/html

# Skopiuj tylko composer.json
COPY composer.json ./

# Uruchom composer install, aby zainstalować zależności i stworzyć composer.lock
RUN composer install --no-interaction --no-plugins --no-scripts

# Teraz skopiuj resztę plików aplikacji
COPY . .

# Ustaw odpowiednie uprawnienia
RUN chown -R www-data:www-data storage bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache

# Dokończ instalację, uruchamiając skrypty
RUN composer dump-autoload --optimize

# Uruchom serwer PHP-FPM
CMD ["php-fpm"]
