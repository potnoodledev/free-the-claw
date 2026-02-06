#!/bin/sh
set -e

CONFIG_FILE="/usr/share/nginx/html/config.json"

# Generate runtime config.json from environment variables
cat > "$CONFIG_FILE" <<EOF
{
  "nodes": {
    "fallbackPublicExplorer": "${EXPLORER_FALLBACK:-https://app.radicle.xyz/nodes/\$host/\$rid\$path}",
    "requiredApiVersion": "~0.18.0",
    "defaultHttpdPort": ${EXPLORER_HTTPD_PORT:-8080},
    "defaultLocalHttpdPort": ${EXPLORER_LOCAL_HTTPD_PORT:-8080},
    "defaultHttpdScheme": "${EXPLORER_HTTPD_SCHEME:-http}"
  },
  "source": {
    "commitsPerPage": 30
  },
  "supportWebsite": "https://radicle.zulipchat.com",
  "preferredSeeds": [
    {
      "hostname": "${EXPLORER_PREFERRED_SEED:-radicle-seed}",
      "port": ${EXPLORER_PREFERRED_SEED_PORT:-8080},
      "scheme": "${EXPLORER_PREFERRED_SEED_SCHEME:-http}"
    }
  ]
}
EOF

echo "Runtime config written to $CONFIG_FILE"
cat "$CONFIG_FILE"

exec "$@"
