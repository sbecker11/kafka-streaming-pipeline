#!/bin/bash
set -e

echo "Starting Zookeeper detached... "
docker compose -f docker/docker-compose.yml up -d zookeeper 

# Wait for Zookeeper to be fully up and running
./scripts/utils/wait-for-zookeeper.sh

echo "Starting Kafka detached... "
docker compose -f docker/docker-compose.yml up -d kafka0 

# Wait for Kafka to be fully up and running
./scripts/utils/wait-for-kafka.sh

echo "Starting my-python-producer detached... "
docker compose -f docker/docker-compose.yml up -d my-python-producer

# Wait for my-python-producer to be fully up and running
./scripts/utils/wait-for-my-python-producer.sh

# List all containers
docker ps -a
