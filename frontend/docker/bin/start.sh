#!/bin/bash

echo "*** Waiting for service dependencies to be up..."
#/devops/wait-for-it.sh $BACKEND_HOST:80 --timeout=0

cd /app
if [ "x${ENV}" == "xdev" ] ; then
  echo "*** Run npm install"
  npm install
  echo "*** Run dev script"
  npm run dev
else
  echo "*** Copy next dir to shared folder"
  chown -R nextjs:nodejs /app/.next
  # TODO: improve rsync options, the destination directory (/mnt/efs/next/) will have many files in the future
  rsync -a /app/.next/ /mnt/efs/next
  rm -rf /app/.next/
  ln -s /mnt/efs/next /app/.next
  ln -s /app/node_modules /mnt/node_modules
  echo "*** Run nodev script"
  exec gosu nextjs \
    node server.js
fi
