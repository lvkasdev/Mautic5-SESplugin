# Dockerfile Simplificado que usa un Entrypoint Script

# 1. Usar la imagen oficial de Mautic como base
FROM mautic/mautic:5.0.4-apache

# 2. Cambiar a usuario ROOT para instalar y dar permisos
USER root

# 3. Instalar herramientas básicas si son necesarias (wget y unzip para el otro plugin)
RUN apt-get update && apt-get install -y --no-install-recommends wget unzip && rm -rf /var/lib/apt/lists/*

# --- INSTALAR PLUGIN 1: Amazon SES (Método manual por ZIP) ---
# Este método sigue funcionando bien aquí porque es solo una copia de archivos.
ARG PLUGIN_SES_NAME=MauticAmazonSesBundle
ARG PLUGIN_SES_URL=https://github.com/pabloveintimilla/mautic-amazon-ses/archive/refs/heads/main.zip

RUN wget -O plugin-ses.zip "${PLUGIN_SES_URL}" \
    && unzip -q plugin-ses.zip -d /var/www/html/plugins/ \
    && mv /var/www/html/plugins/mautic-amazon-ses-main /var/www/html/plugins/${PLUGIN_SES_NAME} \
    && rm plugin-ses.zip

# --- CONFIGURAR EL ENTRYPOINT SCRIPT ---
# Copiamos nuestro script personalizado al contenedor
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Nos aseguramos de que sea ejecutable dentro del contenedor también
RUN chmod +x /usr/local/bin/entrypoint.sh

# Le decimos a Docker que use nuestro script como el nuevo punto de entrada
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# El CMD original de la imagen base de Mautic es 'apache2-foreground'.
# Nuestro script lo recibirá gracias a 'exec "$@"'
CMD ["apache2-foreground"]
