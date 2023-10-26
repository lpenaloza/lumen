FROM node:lts-bullseye-slim

COPY docker/bin/start.sh /devops/start.sh
COPY docker/bin/wait-for-it.sh /devops/wait-for-it.sh

RUN chmod 755 /devops/*.sh

CMD /devops/start.sh