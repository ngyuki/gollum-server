#!/bin/sh

if [ ! -e /app/config.ru -a -n "$GOLLUM_CONFIG" ]; then
  echo "$GOLLUM_CONFIG" > /app/config.ru
fi

exec bundle exec thin -p 3000 -e production -l /dev/stdout start
