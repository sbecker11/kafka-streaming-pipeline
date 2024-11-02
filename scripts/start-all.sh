#!/bin/bash
set -e

echo "Starting zookeeper detached... "
docker compose -f docker/docker-compose.yml up -d zookeeper 

# Wait for Zookeeper to be fully up and running
./scripts/utils/wait-for-service.sh zookeeper 2181

echo "Starting kafka detached... "
docker compose -f docker/docker-compose.yml up -d kafka 

# Wait for Kafka to be fully up and running
./scripts/utils/wait-for-service.sh kafka 9092

echo "Starting producer detached... "
docker compose -f docker/docker-compose.yml up -d producer

# Wait for producer to be fully up and running
./scripts/utils/healthcheck_producer0

# List all containers
docker ps -a
