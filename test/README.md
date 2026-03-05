# Test

A Docker image for HTTP testing. It is helpful to test load balancing scenarios.

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `HOSTNAME_TAG` | Safe hostname tag to return to client. | `abc` |

## Docker Build & Run

```bash
# Build
docker build -t test:latest .

# Run (example)
docker run -d \
  -e HOSTNAME_TAG=$HOSTNAME_TAG \
  test:latest
```