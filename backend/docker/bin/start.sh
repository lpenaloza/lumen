#!/bin/bash

echo "*** set application user and group"
if [ ! -z $APP_UID ] ; then
  # this is for docker-compose environment
  # create a user in the container with the same UID that exists in the docker host
  # with this we can avoid permissions issues sharing files
  export APP_GID=$APP_UID
  useradd -u $APP_UID -s /sbin/nologin dummy
  usermod -o -u $APP_UID -g $APP_GID www-data
fi


echo "*** install update composer"
cd /var/www
composer update
php artisan migrate -n --force

echo "*** Starts php-fpm process"
/usr/local/sbin/php-fpm -D

#echo "*** Starts php-fpm process"
#/usr/sbin/php-fpm8.0 -D --fpm-config /etc/php/8.0/fpm/php-fpm.conf

#echo "*** Starts apache process"
#rm -f /var/run/apache2/apache2.pid
#/usr/sbin/apachectl -D FOREGROUND
