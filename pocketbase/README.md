# PocketBase

A Docker image for deploying [PocketBase](https://pocketbase.io/docs/), an open-source backend for building modern applications.

## Features

- **Self-contained Backend**: SQLite database and REST API in one
- **Admin Dashboard**: Built-in UI for database and user management
- **Lightweight**: Alpine Linux base for minimal footprint
- **Pre-configured**: Automatic admin user creation on startup

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `ADMIN_EMAIL` | Admin account email | `admin@example.com` |
| `ADMIN_PASSWORD` | Admin account password | `secure-password-123` |

## Docker Build & Run

```bash
# Build
docker build -t pocketbase:latest .

# Run (example)
docker run -d \
  -e ADMIN_EMAIL=admin@example.com \
  -e ADMIN_PASSWORD=secure-password-123 \
  -p 8080:8080 \
  -v pb-data:/pb_data \
  -v pb-public:/pb_public \
  -v pb-hooks:/pb_hooks \
  pocketbase:latest
```

- The application is served as port `8080`. Admin dashboard can be accessed at `:8080/_/`
- The following container paths can be mounted to volumes -
    - `/pb_data`: SQLite database and uploaded files
    - `/pb_public`: Static files served publicly
    - `/pb_hooks`: Custom JavaScript hooks