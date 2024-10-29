#!/bin/bash
# Full cleanup script for the Kafka streaming pipeline.
# Stops all containers and removes associated volumes to ensure a fresh start.
# Optionally prompts to remove all unused Docker resources.
# Usage: ./full-cleanup.sh

# To exit on first error in the script.
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
