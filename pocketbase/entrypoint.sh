#!/usr/bin/env sh
set -e

# Check required environment variables
ENV_NOT_SET=false
# Function to check required environment variables
check_env_var() {
  local var_name=$1
  if [ -z "${!var_name}" ]; then
    echo "Error: Environment Variable $var_name is not set. Exiting."
    ENV_NOT_SET=true
  fi
}

# List of required environment variables
REQUIRED_ENV_VARS=("ADMIN_EMAIL" "ADMIN_PASSWORD")

for var in "${REQUIRED_ENV_VARS[@]}"; do
  check_env_var "$var"
done

if [ "$ENV_NOT_SET" = true ]; then
  exit 1
fi

# Create Admin Superuser
/usr/local/bin/pocketbase superuser upsert "$ADMIN_EMAIL" "$ADMIN_PASSWORD" --dir=/pb_data

# Run PocketBase on port 8080
exec /usr/local/bin/pocketbase serve --dir=/pb_data --publicDir=/pb_public --hooksDir=/pb_hooks "$@"    