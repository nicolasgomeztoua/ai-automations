# Use the official n8n image
FROM docker.n8n.io/n8nio/n8n:latest

# The base image already sets the correct WORKDIR and CMD,
# so we don't need to specify them here.

# Expose the default n8n port (the platform needs to map this)
EXPOSE 5678

# Optional: Add healthcheck (platforms might use this)
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl --fail http://localhost:5678/healthz || exit 1

# Note: Environment variables must be set in the deployment platform.
# Note: Persistent volume for /home/node/.n8n should be configured in the platform if possible. 