#!/bin/bash

# https://github.com/docker/compose/issues/2380
# export UID of the current user, we use this to set the permission from the container to the wordpress files..
# the current user will be able to edit the files from the docker host
export UID

[ ! -f "common.env" ] && echo "common.env not found" && exit 1
[ ! -L ".env" ] && ln -s common.env .env

docker-compose "$@"