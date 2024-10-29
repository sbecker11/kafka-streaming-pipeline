#!/bin/bash
set -e

echo "Checking Kafka services..."

# Check service status
echo "Service Status:"
docker compose -f docker/docker-compose.yml \
               -f docker/docker-compose.kafka.yml ps

# Check container resources
echo -e "\nResource Usage:"
docker compose -f docker/docker-compose.yml \
               -f docker/docker-compose.kafka.yml top

# List Kafka topics
echo -e "\nKafka Topics:"
docker compose -f docker/docker-compose.yml \
               -f docker/docker-compose.kafka.yml \
               exec -T kafka kafka-topics.sh --bootstrap-server localhost:9092 --list

# Check if data generator is producing
echo -e "\nChecking data generator logs:"
docker compose -f docker/docker-compose.yml \
               -f docker/docker-compose.kafka.yml \
               logs --tail=10 kafka-data-generator
               