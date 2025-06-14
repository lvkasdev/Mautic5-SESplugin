# Mautic 5 con Plugin Amazon SES en Docker

Este repositorio contiene la configuración de Docker para desplegar una instancia de Mautic 5, con una imagen personalizada que incluye el [Plugin de Amazon SES para Mautic](https://github.com/pabloveintimilla/mautic-amazon-ses).

El stack está optimizado para un despliegue sencillo y profesional utilizando Portainer.

## ✨ Características

- **Mautic 5.0.4**: La última versión estable de Mautic.
- **Plugin Amazon SES Pre-instalado**: Imagen de Docker personalizada que incluye el plugin de SES listo para ser activado.
- **PHP 8.1**: La versión de PHP recomendada y empaquetada con la imagen oficial de Mautic.
- **Docker Compose**: Toda la configuración definida como infraestructura como código para un despliegue repetible.
- **Listo para Portainer**: Configurado para un despliegue rápido desde un repositorio de Git.

## 🚀 Cómo Empezar

Antes de desplegar el stack, necesitas configurar tus variables de entorno locales.

### 1. Clona el Repositorio

Si aún no lo has hecho, clona este repositorio a tu máquina local:
```bash
git clone [https://github.com/lvkasdev/Mautic5-SESplugin.git](https://github.com/lvkasdev/Mautic5-SESplugin.git)
cd Mautic5-SESplugin
```

### 2. Crea tu archivo `.env`

Este proyecto utiliza un archivo `.env` para gestionar secretos y configuraciones específicas de tu entorno. **Este archivo nunca debe ser subido a Git.**

1.  Crea una copia del archivo de ejemplo:
    ```bash
    cp .env.example .env
    ```

2.  Edita el nuevo archivo `.env` con tus propios valores. Reemplaza los placeholders como `CAMBIAR_POR...` con tus contraseñas y datos reales.

## 🐳 Instalación en Portainer

Este método utiliza la funcionalidad de Portainer para desplegar directamente desde un repositorio de Git, lo cual es la práctica recomendada.

1.  **Inicia Sesión en Portainer** y selecciona el entorno donde quieres desplegar.

2.  En el menú de la izquierda, ve a **Stacks**.

3.  Haz clic en **+ Add stack**.

4.  **Configura el Despliegue:**
    * **Name**: Dale un nombre a tu stack (ej. `mautic-produccion`).
    * **Deployment method**: Selecciona **Repository**.
    * **Repository URL**: Pega la URL de tu repositorio de GitHub: `https://github.com/lvkasdev/Mautic5-SESplugin`
    * **Compose path**: Deja el valor por defecto, `docker-compose.yml`.
    * **Load environment variables from .env file**: **Activa esta opción**. Portainer leerá automáticamente tu archivo `.env.example` para saber qué variables necesita.

5.  **Añade tus Secretos:**
    * En la sección **Environment variables**, selecciona la pestaña **Advanced**.
    * Portainer te mostrará las variables definidas en tu `.env.example`. Introduce los valores secretos correspondientes para tu entorno de producción.

6.  **Despliega el Stack:**
    * Haz clic en el botón **Deploy the stack**.

Portainer ahora clonará tu repositorio, construirá la imagen de Docker personalizada (esto puede tardar unos minutos la primera vez), y luego iniciará todos los servicios.

## ⚙️ Post-Instalación

Una vez que el stack esté funcionando, completa la configuración final.

### 1. Accede a Mautic
Abre tu navegador y ve a la URL que configuraste en tu variable `MAUTIC_URL` (ej. `http://tu-servidor-ip:8081`).

### 2. Configuración Web de Mautic
Mautic te guiará a través de los últimos pasos de instalación, donde principalmente tendrás que crear tu usuario administrador. La conexión a la base de datos ya estará configurada.

### 3. Activa el Plugin de Amazon SES
1.  Dentro de Mautic, ve al menú de **Configuración** (icono de engranaje ⚙️).
2.  Selecciona **Plugins**.
3.  Haz clic en el botón **Install/Upgrade Plugins** en la esquina superior derecha.
4.  Busca el plugin **Amazon SES** en la lista.
5.  Actívalo y configúralo con tus credenciales de AWS (Access Key y Secret Key).

¡Felicidades! Ahora tienes una instancia de Mautic totalmente funcional y profesional.
