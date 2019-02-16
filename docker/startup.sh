#!/bin/bash

if [ ! -e /app/config.ru -a -v GOLLUM_CONFIG ]; then
  echo "$GOLLUM_CONFIG" > /app/config.ru
fi

exec bundle exec thin -p 3000 -e production start
