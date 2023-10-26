FROM debian:latest

RUN apt-get update && apt-get install -y  \
    nginx  \
    openssl \
    unzip && \
  mkdir -p /var/www/html

WORKDIR /

EXPOSE 80 443

COPY proxy/conf/nginx.conf /etc/nginx/nginx.conf
COPY proxy/bin/start.sh /devops/start.sh
COPY proxy/bin/wait-for-it.sh /devops/wait-for-it.sh

RUN \
  chmod 755 /devops/start.sh && \
  chmod 755 /devops/wait-for-it.sh

CMD /devops/start.sh
