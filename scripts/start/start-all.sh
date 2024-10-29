#!/bin/bash

# Set script to exit immediately if a command exits with a non-zero status
set -e

# Load environment variables
if [ -f .env ]; then
    source .env
else
    echo "Error: .env file not found"
    exit 1
fi

# Set working directory to project root
cd "$(dirname "$0")/../.."

echo "Starting all services..."

# Create required directories if they don't exist
mkdir -p data/processed

# Start all services
docker-compose -f docker/docker-compose.yml \
               -f docker/docker-compose.kafka.yml \
               -f docker/docker-compose.monitor.yml \
               -f docker/docker-compose.app.yml up -d

# Wait for services to be healthy
echo "Waiting for services to be healthy..."
./scripts/utils/check-kafka.sh
./scripts/utils/check-monitoring.sh

echo "All services started successfully!"
echo "Grafana: http://localhost:3000"
echo "Prometheus: http://localhost:9090"
echo "Consumer Metrics: http://localhost:8000/metrics"
