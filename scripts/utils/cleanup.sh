#!/bin/bash
set -e

echo "Cleaning up Kafka services..."

# Stop and remove containers, networks, and volumes
docker compose -f docker/docker-compose.yml \
               -f docker/docker-compose.kafka.yml down -v

# Optional: Remove all unused Docker resources
read -p "Remove all unused Docker resources? (y/n) " answer
if [ "$answer" = "y" ]; then
    docker system prune -f
fi
