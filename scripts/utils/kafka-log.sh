#!/bin/bash
# Script to view logs for Kafka or any other specified service.
# Supports multiple arguments to specify services and options for logs.
# See below for Usage instructions.

# To exit on first error in the script.
set -e

# Usage Instructions: ./log-kafka.sh [options] [services...]
# Examples:
# ./log-kafka.sh --follow kafka zookeeper   # Follow logs for both Kafka and Zookeeper
# ./log-kafka.sh --tail 100 zookeeper       # Show last 100 lines for Zookeeper only
# ./log-kafka.sh kafka                      # Show logs for Kafka only

# Pass all arguments to the docker compose logs command, allowing for specific service logs
docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml logs "$@"
