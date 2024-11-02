#!/bin/bash
set -e

# Default to 'kafka' service if no arguments are provided
SERVICE_OR_CONTAINER=${1:-kafka}
shift || true # Shift arguments if additional arguments are provided

# Usage: ./kafka-log.sh [service_or_container] [options]
# Examples:
#   ./kafka-log.sh                # Shows logs for Kafka service - DEFAULT
#   ./kafka-log.sh kafka --follow # Follows Kafka service logs
#   ./kafka-log.sh kafka-pipeline-kafka-1 # Shows logs for a specific container

# Debug: List all running containers and services
echo "Listing all running containers:"
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}"
echo
echo -e "\nListing all services in Docker Compose:"
docker compose -f docker/docker-compose.yml ps

# Attempt to get the actual container name for a Docker Compose service
CONTAINER_NAME=$(docker compose -f docker/docker-compose.yml ps -q "$SERVICE_OR_CONTAINER" 2>/dev/null)

if [ -n "$CONTAINER_NAME" ]; then
    # Service name found in Docker Compose
    echo "Fetching logs for service '$SERVICE_OR_CONTAINER' (container ID: $CONTAINER_NAME)..."
    docker logs "$CONTAINER_NAME" "$@"
else
    # Fallback to treat it as a direct container name if no service found
    echo "Attempting to fetch logs for container '$SERVICE_OR_CONTAINER'..."
    if docker ps -a --format '{{.Names}}' | grep -q "^$SERVICE_OR_CONTAINER$"; then
        docker logs "$SERVICE_OR_CONTAINER" "$@"
    else
        echo "Error: No such service or container named '$SERVICE_OR_CONTAINER'."
        exit 1
    fi
fi
