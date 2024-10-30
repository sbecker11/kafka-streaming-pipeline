#!/bin/bash
set -e

echo "Stopping Kafka and Zookeeper..."

# Stop only Kafka and Zookeeper services, appending any additional arguments, like -v to delete volumes
docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml down $@

# Optional: Stop Kafka, Zookeeper, and application services (producer/consumer)
# Uncomment the line below to stop Kafka, Zookeeper, and application services
# docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml -f docker/docker-compose.app.yml down

# Optional: Stop the full pipeline with monitoring (Kafka, Zookeeper, application, and monitoring)
# Uncomment the line below to stop all services including monitoring
# docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml -f docker/docker-compose.app.yml -f docker/docker-compose.monitor.yml down

# Optional: Remove all volumes (for a full clean-up)
# Uncomment the line below to remove all Docker volumes related to the project
# WARNING: This will delete all stored data for Zookeeper, Kafka, and other services
# docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml -f docker/docker-compose.app.yml -f docker/docker-compose.monitor.yml down -v

echo "All specified services have been stopped."
