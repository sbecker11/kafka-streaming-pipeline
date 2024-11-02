#!/bin/bash
# Script to check if Kafka is running by attempting a status check.
# This script verifies if Kafka is operational within the Docker Compose setup.
# NOTE: This script is intended for use after Kafka and related services have started.
#       It is not a system pre-check and will only work if services are already running.
# See below for Usage instructions.

# To exit on first error in the script.
set -e

# Usage instructions:
#
# scripts/utils/kafka-status

echo -e "\nKafka Container Status:"
docker ps -a | grep kafka

echo "Checking Kafka services..."

# Display service status for Kafka and Zookeeper
echo "Service Status:"
docker compose -f docker/docker-compose.yml ps

# Display resource usage for Kafka and Zookeeper containers
echo -e "\nResource Usage:"
docker compose -f docker/docker-compose.yml top

# List all Kafka topics in the current Kafka broker
echo -e "\nKafka Topics:"
docker compose -f docker/docker-compose.yml \
               exec -T kafka kafka-topics.sh --bootstrap-server localhost:9092 --list

echo "Checking Kafka Topics:"
docker exec -it kafka kafka-topics --bootstrap-server localhost:9092 --list

# Display the last 10 lines of logs for the Kafka data generator
echo -e "\nChecking data generator logs:"
docker compose -f docker/docker-compose.yml \
               logs --tail=10 kafka-data-generator
