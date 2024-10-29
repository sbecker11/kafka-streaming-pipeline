#!/bin/bash
set -e

cd "$(dirname "$0")/../.."

echo "Rebuilding consumer service..."

# Stop consumer service
docker-compose -f docker/docker-compose.yml \
               -f docker/docker-compose.app.yml stop consumer

# Remove consumer container
docker-compose -f docker/docker-compose.yml \
               -f docker/docker-compose.app.yml rm -f consumer

# Rebuild and start consumer
docker-compose -f docker/docker-compose.yml \
               -f docker/docker-compose.app.yml up -d --build consumer

echo "Consumer service rebuilt and started!"
