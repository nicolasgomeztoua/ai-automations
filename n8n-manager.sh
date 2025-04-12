#!/bin/bash

# n8n Management Script

# Change to the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$SCRIPT_DIR"

# Function to display help
show_help() {
    echo "Usage: ./n8n-manager.sh [option]"
    echo ""
    echo "Options:"
    echo "  start       Start n8n container"
    echo "  stop        Stop running container"
    echo "  restart     Restart container"
    echo "  update      Update n8n to the latest version"
    echo "  status      Show container status"
    echo "  logs        Show container logs"
    echo "  help        Show this help message"
    echo ""
}

# Function to check if Docker and Docker Compose are available
check_requirements() {
    if ! command -v docker &> /dev/null; then
        echo "Error: Docker is not installed or not in the PATH"
        exit 1
    fi
    
    # Try docker compose first
    if command -v docker compose &> /dev/null; then
        COMPOSE_CMD="docker compose"
    # Fallback to docker-compose
    elif command -v docker-compose &> /dev/null; then
        COMPOSE_CMD="docker-compose"
    else
        echo "Error: Neither 'docker compose' nor 'docker-compose' found in PATH."
        exit 1
    fi
}

# Start container
start() {
    echo "Starting n8n container..."
    $COMPOSE_CMD up -d
    echo "n8n is now available at http://localhost:${N8N_PORT:-5678}"
}

# Stop container
stop() {
    echo "Stopping container..."
    $COMPOSE_CMD down
}

# Restart container
restart() {
    echo "Restarting container..."
    $COMPOSE_CMD restart
}

# Update n8n to the latest version
update() {
    echo "Updating n8n to the latest version..."
    $COMPOSE_CMD pull
    $COMPOSE_CMD down
    $COMPOSE_CMD up -d
    echo "Update complete. n8n is now available at http://localhost:${N8N_PORT:-5678}"
}

# Show container status
status() {
    echo "Container status:"
    $COMPOSE_CMD ps
}

# Show container logs
logs() {
    echo "Container logs:"
    $COMPOSE_CMD logs "$@"
}

# Main script logic
check_requirements

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    update)
        update
        ;;
    status)
        status
        ;;
    logs)
        shift
        logs "$@"
        ;;
    help|--help|-h|"")
        show_help
        ;;
    *)
        echo "Unknown option: $1"
        show_help
        exit 1
        ;;
esac

exit 0 