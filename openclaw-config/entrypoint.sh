#!/bin/sh
# Copy config files into the named volume, replacing __MODEL__ placeholder
sed "s|__MODEL__|${MODEL:-moonshotai/kimi-k2-thinking}|g" /openclaw-config/openclaw.json \
  > /home/node/.openclaw/openclaw.json 2>/dev/null || true
chown -R node:node /home/node/.openclaw

exec "$@"
