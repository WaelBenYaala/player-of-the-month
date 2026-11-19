# Étape 1 : dépendances PHP
FROM composer:2 AS vendor
WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-scripts --no-autoloader --prefer-dist --ignore-platform-reqs
COPY . .
RUN composer dump-autoload --optimize --no-dev --ignore-platform-reqs

# Étape 2 : build du frontend
FROM node:20-alpine AS assets
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Étape 3 : exécution
FROM php:8.3-cli-alpine
WORKDIR /var/www/html
RUN apk add --no-cache postgresql-dev \
    && docker-php-ext-install pdo pdo_pgsql
RUN adduser -D -u 1000 appuser
COPY --from=vendor --chown=appuser:appuser /app .
COPY --from=assets --chown=appuser:appuser /app/public/build ./public/build
USER appuser
EXPOSE 3000
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=3000"]