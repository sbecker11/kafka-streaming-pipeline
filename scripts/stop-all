#!/bin/bash
set -e

echo "Stopping Kafka and its services ..."

# Find all containers in the docker_kafka-network
containers=$(docker ps -q --filter network=docker_kafka-network)

# Stop and remove those containers
if [ -n "$containers" ]; then
  echo "Stopping and removing containers in the docker_kafka-network..."
  docker stop $containers
  docker rm $containers
fi

# Bring down the Docker Compose services, with appended options. E.g. to delete all volumes add -v
docker compose -f docker/docker-compose.yml down $@

echo "Kafka and its services have been stopped."git 