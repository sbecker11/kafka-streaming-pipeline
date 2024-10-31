#!/bin/bash
set -e

echo "Checking ports before starting..."
./scripts/utils/check-ports.sh

echo "Starting producer in attached mode"

# Make sure other services are stopped first
docker compose -f docker/docker-compose.yml down

# Start just the producer (and its dependencies)
docker compose -f docker/docker-compose.yml up my-python-producer
