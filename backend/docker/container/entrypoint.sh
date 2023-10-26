#!/bin/sh

if [ ! -d "/var/www/vendor" ]; then
  echo "El directorio vendor no está instalado. Ejecutando composer install..."
  composer install --prefer-dist --no-dev
fi

if [ -z "$1" ]; then
  /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
else
  $*
fi
