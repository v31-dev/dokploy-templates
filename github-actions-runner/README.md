# GitHub Actions Self-Hosted Runner

A Docker image for GitHub Actions self-hosted organization runners.

## Features

- **Ephemeral Mode**: Auto-cleans after each job for security
- **Non-root User**: Runs as `github` user
- **Pre-installed Tools**: Python, Go, Node.js, npm, and common utilities
- **Health Checks**: Built-in monitoring for Dokploy compatibility
- **Lightweight**: Minimal footprint with only essential dependencies

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `GITHUB_TOKEN` | GitHub PAT with required permissions | `ghp_xxxxx...` |
| `ORG` | GitHub organization name | `my-org` |
| `LABELS` | Comma-separated runner labels | `linux,self-hosted` |
| `NAME` | Base name for the runner (random suffix auto-appended) | `my-runner` |

## GitHub Token

1. Go to GitHub Settings → Developer settings → Personal access tokens
2. Create a new token with permissions:
   - `Repository access` - default
   - `Self-hosted runners` read & write
3. Use this token as `GITHUB_TOKEN` in your Dokploy deployment

## Docker Build & Run

```bash
# Build
docker build -t github-runner:latest .

# Run (example)
docker run -d \
  -e GITHUB_TOKEN=$GITHUB_TOKEN \
  -e ORG=$ORG \
  -e LABELS="linux,self-hosted" \
  -e NAME="custom-runner" \
  github-runner:latest
```