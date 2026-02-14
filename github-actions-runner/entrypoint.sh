#!/bin/bash
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
REQUIRED_ENV_VARS=("LABELS" "ORG" "GITHUB_TOKEN" "NAME")

for var in "${REQUIRED_ENV_VARS[@]}"; do
  check_env_var "$var"
done

if [ "$ENV_NOT_SET" = true ]; then
  exit 1
fi

# Generate unique runner name with random suffix
RANDOM_NAME=$(head /dev/urandom | tr -dc 'A-Za-z0-9' | head -c 16)
RUNNER_NAME="$NAME-$RANDOM_NAME"

# Get runner registration token
TOKEN=$(gh api --method POST \
  -H "Accept: application/vnd.github+json" \
  /orgs/$ORG/actions/runners/registration-token | jq -r '.token')

cd /actions-runner

# Configure runner
./config.sh --url https://github.com/$ORG --token $TOKEN --unattended --ephemeral \
  --labels $LABELS --name $RUNNER_NAME

# Run
./run.sh