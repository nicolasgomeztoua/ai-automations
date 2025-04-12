# n8n with Neon PostgreSQL Database

This setup configures n8n to connect to an external Neon PostgreSQL database.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- A Neon PostgreSQL database account (already configured in .env)

## Configuration

The files include:

- `docker-compose.yml` - n8n container configuration
- `.env` - Environment variables with database connection details
- `n8n-manager.sh` - Management script for easier operation

### Environment Variables

The `.env` file contains the configuration for the n8n instance and the Neon PostgreSQL connection:

| Variable | Description |
|----------|-------------|
| N8N_PORT | Port to access n8n (default: 5678) |
| N8N_PROTOCOL | Protocol for n8n (http/https) |
| N8N_HOST | Host for n8n |
| POSTGRES_HOST | Neon PostgreSQL host |
| POSTGRES_PORT | PostgreSQL port (default: 5432) |
| POSTGRES_USER | PostgreSQL username |
| POSTGRES_PASSWORD | PostgreSQL password |
| POSTGRES_DB | PostgreSQL database name |
| POSTGRES_SCHEMA | PostgreSQL schema (default: public) |
| POSTGRES_SSL_MODE | SSL mode for PostgreSQL (require) |
| GENERIC_TIMEZONE | Timezone for n8n (Atlantic/Canary) |
| TZ | System timezone (Atlantic/Canary) |
| N8N_ENCRYPTION_KEY | Encryption key for credentials (recommended for production) |

## Usage

### Using the Management Script

```bash
# Make the script executable (first time only)
chmod +x n8n-manager.sh

# Start n8n
./n8n-manager.sh start

# Check status
./n8n-manager.sh status

# View logs
./n8n-manager.sh logs

# View logs and follow output
./n8n-manager.sh logs -f

# Update n8n
./n8n-manager.sh update

# Stop n8n
./n8n-manager.sh stop

# Show help
./n8n-manager.sh help
```

### Manual Docker Compose Commands

You can also manage the setup directly with Docker Compose:

```bash
# Start
docker compose up -d

# Stop
docker compose down

# Update
docker compose pull
docker compose down
docker compose up -d
```

## Security Notes

1. For production use, set a secure encryption key by uncommenting and changing the `N8N_ENCRYPTION_KEY` in the `.env` file.
2. Consider using a reverse proxy with SSL for production environments.
3. The database credentials in the `.env` file should be kept secure.

## Persistence

Your n8n data (workflows, credentials, etc.) is stored in a Docker volume:
- `n8n_data`: Contains n8n workflows, credentials, and configurations

The actual database data is stored in your Neon PostgreSQL cloud service. 