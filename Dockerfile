FROM php:8.2-cli
WORKDIR /var/www/html
COPY index.php /var/www/html/
EXPOSE 80
ENTRYPOINT ["php", "-S", "0.0.0.0:80", "index.php"]
