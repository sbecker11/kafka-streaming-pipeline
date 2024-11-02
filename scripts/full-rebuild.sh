#!/bin/bash
# Full rebuild script for the Kafka streaming pipeline.
# Stops all containers, removes volumes, rebuilds images, and restarts services.
# Useful for applying configuration or code changes that require a clean setup.
# Usage: ./full-rebuild

# To exit on first error in the script.
set -e

docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml down --volumes --remove-orphans
docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml up -d --build
