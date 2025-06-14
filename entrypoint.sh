#!/bin/bash

# Este script se ejecuta cada vez que el contenedor de Mautic se inicia.

# 'set -e' asegura que el script se detenga si cualquier comando falla.
set -e

# --- Lógica de Instalación del Plugin ---
# Verificamos si la carpeta del plugin NO existe.
# Esto hace que el script solo instale el plugin la PRIMERA VEZ que se inicia el contenedor.
# En reinicios posteriores, la carpeta ya existirá y este bloque se saltará.
if [ ! -d "/var/www/html/plugins/MauticAmazonSnsBundle" ]; then
    echo "El plugin de Amazon SNS no está instalado. Instalando ahora..."

    # Navegamos a la raíz de la aplicación Mautic
    cd /var/www/html

    # Ejecutamos el comando de instalación del marketplace
    php bin/console mautic:marketplace:install matbcvo/mautic-amazon-sns-callback

    # Limpiamos la caché para que Mautic reconozca el nuevo plugin
    php bin/console cache:clear

    echo "Plugin de Amazon SNS instalado correctamente."
else
    echo "El plugin de Amazon SNS ya está instalado. Saltando la instalación."
fi

# --- Continuar con el Arranque Normal ---
# Esta última línea es CRUCIAL. 'exec "$@"' pasa el control al comando
# original que el contenedor iba a ejecutar (en este caso, iniciar Apache).
# Sin esto, el contenedor se detendría después de ejecutar nuestro script.
exec "$@"
