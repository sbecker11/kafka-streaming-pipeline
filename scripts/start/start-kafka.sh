#!/bin/bash
set -e

echo "Starting Kafka services..."

# Start Kafka stack
docker compose -f docker/docker-compose.yml \
               -f docker/docker-compose.kafka.yml up -d

# Check services
echo "Checking service status..."
docker compose -f docker/docker-compose.yml \
               -f docker/docker-compose.kafka.yml ps

echo "To view logs use:"
echo "docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml logs -f"
echo "docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml logs -f kafka"
echo "docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml logs -f zookeeper"
echo "docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml logs -f kafka-data-generator"