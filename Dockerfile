# Dockerfile para crear una imagen de Mautic personalizada con el plugin de Amazon SES

# 1. Usar la imagen oficial de Mautic como base
FROM mautic/mautic:5.0.4-apache

# 2. Definir argumentos para la URL del plugin para fácil modificación
ARG PLUGIN_NAME=MauticAmazonSesBundle
ARG PLUGIN_URL=https://github.com/pabloveintimilla/mautic-amazon-ses/archive/refs/heads/main.zip

# 3. Cambiar a usuario ROOT para poder instalar paquetes y escribir en el sistema
USER root

# 4. Instalar herramientas necesarias (wget para descargar, unzip para descomprimir)
#    y limpiar la caché de apt para mantener la imagen ligera.
RUN apt-get update && apt-get install -y --no-install-recommends wget unzip && rm -rf /var/lib/apt/lists/*

# 5. Descargar el plugin, descomprimirlo en la carpeta de plugins de Mautic,
#    renombrar la carpeta y limpiar los archivos de descarga.
RUN wget -O plugin.zip "${PLUGIN_URL}" \
    && unzip -q plugin.zip -d /var/www/html/plugins/ \
    && mv /var/www/html/plugins/mautic-amazon-ses-main /var/www/html/plugins/${PLUGIN_NAME} \
    && rm plugin.zip

# 6. Asignar los permisos correctos al directorio del nuevo plugin para que el servidor web pueda usarlo
RUN chown -R www-data:www-data /var/www/html/plugins/${PLUGIN_NAME}

# 7. Volver al usuario por defecto de Mautic por seguridad
USER www-data
