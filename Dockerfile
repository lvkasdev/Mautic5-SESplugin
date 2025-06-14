# Dockerfile v4 - Forzando la reconstrucción para asegurar los últimos cambios
FROM mautic/mautic:5.0.4-apache

USER root

RUN apt-get update && apt-get install -y --no-install-recommends wget unzip && rm -rf /var/lib/apt/lists/*

# --- INSTALAR PLUGIN 1: Amazon SES (Método manual por ZIP) ---
ARG PLUGIN_SES_NAME=MauticAmazonSesBundle
ARG PLUGIN_SES_URL=https://github.com/pabloveintimilla/mautic-amazon-ses/archive/refs/heads/main.zip

RUN wget -O plugin-ses.zip "${PLUGIN_SES_URL}" \
    && unzip -q plugin-ses.zip -d /var/www/html/plugins/ \
    && mv /var/www/html/plugins/mautic-amazon-ses-main /var/www/html/plugins/${PLUGIN_SES_NAME} \
    && rm plugin-ses.zip

# --- CONFIGURAR EL ENTRYPOINT SCRIPT ---
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["apache2-foreground"]
