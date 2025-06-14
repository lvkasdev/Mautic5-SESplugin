#!/bin/bash
set -e

if [ ! -f /var/www/html/config/local.php ]; then
    echo ">>>> PRIMERA EJECUCIÓN DETECTADA: Mautic no está instalado."
    echo ">>>> Iniciando proceso de instalación automatizada..."

    php /var/www/html/bin/console mautic:install \
      # ... (todos los parámetros de mautic:install se quedan igual)
      --no-interaction

    echo ">>>> Base de datos de Mautic instalada y configurada."

    # --- LÍNEA PROBLEMÁTICA COMENTADA TEMPORALMENTE ---
    echo ">>>> [DEPURACIÓN] Saltando la instalación del plugin de SNS para estabilizar el entorno."
    # php /var/www/html/bin/console mautic:marketplace:install matbcvo/mautic-amazon-sns-callback

    echo ">>>> Limpiando la caché de Mautic..."
    php /var/www/html/bin/console cache:clear
    # ... (el resto del script se queda igual)

else
    echo ">>>> Mautic ya está instalado. Saltando la instalación."
fi

echo ">>>> Iniciando servidor web Apache..."
exec "$@"
