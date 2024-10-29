#!/bin/bash
set -e

echo "Stopping Kafka services..."

# Stop Kafka stack
docker compose -f docker/docker-compose.yml \
               -f docker/docker-compose.kafka.yml down

echo "To remove volumes as well, use:"
echo "docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml down -v"
