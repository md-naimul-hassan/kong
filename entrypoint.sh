#!/bin/sh
set -e

# Render (and similar) inject PORT — bind the proxy there when set
if [ -n "${PORT}" ]; then
  export KONG_PROXY_LISTEN="0.0.0.0:${PORT}"
fi

exec /docker-entrypoint.sh "$@"
