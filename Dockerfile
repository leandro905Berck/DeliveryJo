# Imagem base: PHP 8.2 com Apache
FROM php:8.2-apache

# Instala extensões necessárias para PostgreSQL
RUN docker-php-ext-install pdo_pgsql pgsql

# Habilita mod_rewrite para URLs amigáveis (ex: .htaccess nas pastas admin/, cliente/)
RUN a2enmod rewrite

# Define o diretório de trabalho
WORKDIR /var/www/html

# Copia todos os arquivos do projeto para dentro do container
COPY . .

# Ajusta permissões (o Apache roda como www-data)
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Garante que o diretório raiz do Apache é o correto
# (a imagem já está configurada, mas reforçamos)
ENV APACHE_DOCUMENT_ROOT=/var/www/html

# Atualiza a configuração do Apache para usar o DocumentRoot customizado
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf && \
    sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Expor a porta 80
EXPOSE 80

# O comando padrão já inicia o Apache (não precisa de CMD extra)
