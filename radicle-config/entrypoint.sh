#!/bin/sh
set -e

CONFIG="$RAD_HOME/config.json"

# Initialize identity if not already present
if [ ! -d "$RAD_HOME/keys" ]; then
  echo "Initializing Radicle identity..."
  RAD_PASSPHRASE="${RAD_PASSPHRASE:-}" rad auth --stdin --alias "${RAD_ALIAS:-seed}"
fi

# Patch config.json directly (no jq available in minimal image)
# Set listen address to bind all interfaces
sed -i 's/"listen": \[\]/"listen": ["0.0.0.0:8776"]/' "$CONFIG"

# Set seeding policy
if [ -n "$RAD_SEED_POLICY" ]; then
  sed -i "s/\"default\": \"block\"/\"default\": \"$RAD_SEED_POLICY\"/" "$CONFIG"
  sed -i "s/\"default\": \"allow\"/\"default\": \"$RAD_SEED_POLICY\"/" "$CONFIG"
fi

# Add scope to seeding policy if requested
if [ "$RAD_SEED_SCOPE" = "all" ]; then
  sed -i 's/"seedingPolicy": {/"seedingPolicy": {\n      "scope": "all",/' "$CONFIG"
fi

# Set external address if provided
if [ -n "$RAD_EXTERNAL_ADDRESS" ]; then
  sed -i "s|\"externalAddresses\": \[\]|\"externalAddresses\": [\"$RAD_EXTERNAL_ADDRESS\"]|" "$CONFIG"
fi

# Print node info
echo "Node ID: $(rad node status --only nid 2>/dev/null || rad self --nid)"
echo "Configuration applied."

exec "$@"
