#!/bin/bash

mkdir -p /etc/nginx/ssl
echo "*** Check if SSL cert exists"
if [ ! -f /etc/nginx/ssl/ssl.crt ] ; then
  echo "*** Create default SSL cert"
  openssl req \
    -subj "/C=CL/ST=Santiago/L=Santiago/O=Company Name/OU=Org/CN=localhost" \
    -new -newkey rsa:2048 \
    -sha256 \
    -days 365 \
    -nodes \
    -x509 \
    -keyout /etc/nginx/ssl/ssl.key \
    -out /etc/nginx/ssl/ssl.crt
fi

if [ "x${NODE_ENV}" != "xdevelopment" ] ; then
  echo "*** Get SSL key and cert from secrets manager"
  aws secretsmanager get-secret-value --secret-id ss_key_indisa_cl | jq -r .SecretString > /etc/nginx/ssl/ssl.key
  aws secretsmanager get-secret-value --secret-id ss_cert_indisa_cl | jq -r .SecretString > /etc/nginx/ssl/ssl.crt
fi

echo "*** set nginx configuration"
rpl  -q __nginx_worker_connections__ ${NGINX_WORKER_CONNECTIONS:=1024} "/etc/nginx/nginx.conf" > /dev/null 2>&1
rpl  -q __nginx_keepalive_timeout__ ${NGINX_KEEPALIVE_TIMEOUT:=65} "/etc/nginx/nginx.conf" > /dev/null 2>&1

echo "*** Configure domain name"
rpl  -q __domain_name__ ${FRONT_DOMAIN} "/etc/nginx/nginx.conf" > /dev/null 2>&1
rpl  -q __domain_name__ ${FRONT_DOMAIN} "/etc/nginx/http.conf" > /dev/null 2>&1

echo "*** Configure redirects"
RED="/etc/nginx/nginx-redirects.conf"
echo > $RED
for R in $(cat /etc/nginx/nginx-redirects.txt | grep -v "^#") ; do
  SRC=$(echo $R | cut -d "," -f 1)
  DST=$(echo $R | cut -d "," -f 2)
  echo "location ~ $SRC {" >> $RED
  echo "  return 301 https://\$host$DST;" >> $RED
  echo "}" >> $RED
done

echo "*** Starts nginx daemon"
mkdir -p /run/nginx/
/usr/sbin/nginx
