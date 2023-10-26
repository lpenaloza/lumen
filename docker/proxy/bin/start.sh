#!/bin/bash

echo "*** Check if SSL cert exists"
if [ ! -f /etc/nginx/ssl/ssl.crt ] ; then
  echo "*** Create default SSL cert"
  openssl req \
    -subj "/C=CO/ST=Cundinamarca/L=Bogota/O=Company Name/OU=Org/CN=localhost" \
    -new -newkey rsa:2048 \
    -sha256 \
    -days 365 \
    -nodes \
    -x509 \
    -keyout /etc/nginx/ssl/ssl.key \
    -out /etc/nginx/ssl/ssl.crt
fi

echo "*** set nginx configuration"
sed -i "s/__backend_host__/$BACKEND_HOST/g" "/etc/nginx/nginx.conf"
sed -i "s/__frontend_host__/$FRONTEND_HOST/g" "/etc/nginx/nginx.conf"
sed -i "s/__nginx_worker_connections__/$NGINX_WORKER_CONNECTIONS/g" "/etc/nginx/nginx.conf"
sed -i "s/__nginx_keepalive_timeout__/$NGINX_KEEPALIVE_TIMEOUT/g" "/etc/nginx/nginx.conf"
sed -i "s/__nginx_client_max_body_size__/$NGINX_CLIENT_MAX_BODY_SIZE/g" "/etc/nginx/nginx.conf"
sed -i "s/__nginx_client_body_buffer_size__/$NGINX_CLIENT_BODY_BUFFER_SIZE/g" "/etc/nginx/nginx.conf"

echo "*** Wait for backends"
/devops/wait-for-it.sh $BACKEND_HOST:80 -t 30

echo "*** Starts nginx daemon"
nginx -g 'daemon off;'
