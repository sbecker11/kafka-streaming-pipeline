#!/bin/bash
set -e

echo "Starting Zookeeper detached and then Kafka attached..."

# Start Kafka and Zookeeper in detached mode
# docker compose -f docker/docker-compose.yml up -d kafka

# Start zookeeper in detached mode
docker compose -f docker/docker-compose.yml up -d zookeeper 

echo "Zookeeper, Kafka, and My Python Producer are being started. Check logs for details."

# List all containers
docker ps -a
