#!/bin/bash
set -e

echo "Starting Kafka and Zookeeper..."

# Start Kafka and Zookeeper only
docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml up -d zookeeper kafka

# Optional: Start Kafka, Zookeeper, and application services (producer/consumer)
# Uncomment the line below to include application services
# docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml -f docker/docker-compose.app.yml up -d zookeeper kafka my-python-producer

# Optional: Start full pipeline with monitoring (Kafka, Zookeeper, application, and monitoring)
# Uncomment the line below to start all services including monitoring
# docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml -f docker/docker-compose.app.yml -f docker/docker-compose.monitor.yml up -d zookeeper kafka my-python-producer grafana prometheus

# Wait for services to initialize
sleep 5

# Check service status
echo "Checking service status..."
docker compose -f docker/docker-compose.yml ps

# Optional: View logs
echo -e "\nTo view logs, use:"
echo "# View logs once:"
echo "docker compose -f docker/docker-compose.yml logs zookeeper kafka"
echo
echo "# Follow logs (continuous):"
echo "docker compose -f docker/docker-compose.yml logs --follow zookeeper kafka"

echo "To view all logs:"
echo
echo "# View all logs once:"
echo "docker compose -f docker/docker-compose.yml logs"
echo
echo "# Follow all logs (continuous):"
echo "docker compose -f docker/docker-compose.yml logs --follow"
echo
echo "# View specific service logs:"
echo "docker compose -f docker/docker-compose.yml logs kafka"
echo "docker compose -f docker/docker-compose.yml logs zookeeper"
echo "docker compose -f docker/docker-compose.yml logs my-python-producer"
echo
echo "# Follow specific service logs:"
echo "docker compose -f docker/docker-compose.yml logs --follow kafka"
echo "docker compose -f docker/docker-compose.yml logs --follow zookeeper"
echo "docker compose -f docker/docker-compose.yml logs --follow my-python-producer"
