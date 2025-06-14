#!/bin/bash

# Marcador de versión para depuración.
echo ">>>> EJECUTANDO SCRIPT DE ENTRADA v4 - LA VERSIÓN CORREGIDA <<<<"

set -e

if [ ! -f /var/www/html/config/local.php ]; then
    echo ">>>> PRIMERA EJECUCIÓN DETECTADA: Mautic no está instalado."
    echo ">>>> Iniciando proceso de instalación automatizada..."

    # Comando de instalación con la sintaxis corregida.
    php /var/www/html/bin/console mautic:install \
      --db_driver="pdo_mysql" \
      --db_host="$MAUTIC_DB_HOST" \
      --db_port="3306" \
      --db_name="$MAUTIC_DB_NAME" \
      --db_user="$MAUTIC_DB_USER" \
      --db_password="$MAUTIC_DB_PASSWORD" \
      --admin_email="$MAUTIC_ADMIN_EMAIL" \
      --admin_password="$MAUTIC_ADMIN_PASSWORD" \
      --admin_firstname="Admin" \
      --admin_lastname="User" \
      --no-interaction \
      "$MAUTIC_URL"

    echo ">>>> Base de datos de Mautic instalada y configurada."

    echo ">>>> Instalando plugin de Amazon SNS..."
    php /var/www/html/bin/console mautic:marketplace:install matbcvo/mautic-amazon-sns-callback --force
    echo ">>>> Plugin de Amazon SNS instalado."

    echo ">>>> Limpiando la caché de Mautic..."
    php /var/www/html/bin/console cache:clear
    echo ">>>> Caché limpiada."

    echo ">>>> Ajustando permisos de los archivos..."
    chown -R www-data:www-data /var/www/html
    echo ">>>> Permisos ajustados."

    echo ">>>> ¡PROCESO DE INSTALACIÓN AUTOMATIZADA COMPLETADO!"

else
    echo ">>>> Mautic ya está instalado. Saltando la instalación."
fi

echo ">>>> Iniciando servidor web Apache..."
exec "$@"
