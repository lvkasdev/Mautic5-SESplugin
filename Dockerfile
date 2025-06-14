# Dockerfile para crear una imagen de Mautic personalizada con AMBOS plugins de AWS

# 1. Usar la imagen oficial de Mautic como base
FROM mautic/mautic:5.0.4-apache

# 2. Cambiar a usuario ROOT para poder instalar paquetes y escribir en el sistema
USER root

# 3. Instalar herramientas necesarias (wget para descargar, unzip para descomprimir)
RUN apt-get update && apt-get install -y --no-install-recommends wget unzip && rm -rf /var/lib/apt/lists/*


# --- INSTALAR PLUGIN 1: Amazon SES (Método manual por ZIP) ---
ARG PLUGIN_SES_NAME=MauticAmazonSesBundle
ARG PLUGIN_SES_URL=https://github.com/pabloveintimilla/mautic-amazon-ses/archive/refs/heads/main.zip

RUN wget -O plugin-ses.zip "${PLUGIN_SES_URL}" \
    && unzip -q plugin-ses.zip -d /var/www/html/plugins/ \
    && mv /var/www/html/plugins/mautic-amazon-ses-main /var/www/html/plugins/${PLUGIN_SES_NAME} \
    && rm plugin-ses.zip


# --- INSTALAR PLUGIN 2: Amazon SNS (Método Marketplace) ---
# Este es el método oficial de Mautic 5. Se ejecuta directamente desde la consola.
RUN php /var/www/html/bin/console mautic:marketplace:install matbcvo/mautic-amazon-sns-callback


# --- PASOS FINALES DE LIMPIEZA Y PERMISOS ---

# Limpiar la caché después de todas las instalaciones
RUN php /var/www/html/bin/console cache:clear

# Asignar los permisos correctos a TODA la carpeta de plugins para asegurar que todo funcione
RUN chown -R www-data:www-data /var/www/html/plugins

# Volver al usuario por defecto de Mautic por seguridad
USER www-data
