#!/usr/bin/env sh
set -e

# Check required environment variables
check_env_var() {
  local var_name=$1
  eval "var_value=\$$var_name"
  if [ -z "$var_value" ]; then
    echo "Error: Environment Variable $var_name is not set. Exiting."
    exit 1
  fi
}

# Check required variables
check_env_var "ADMIN_EMAIL"
check_env_var "ADMIN_PASSWORD"

# Create Admin Superuser
/usr/local/bin/pocketbase superuser upsert "$ADMIN_EMAIL" "$ADMIN_PASSWORD" --dir=/pb_data

# Run PocketBase on port 8080
exec /usr/local/bin/pocketbase serve --dir=/pb_data --publicDir=/pb_public --hooksDir=/pb_hooks "$@"    