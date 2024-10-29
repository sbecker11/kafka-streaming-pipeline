#!/bin/bash
# Script to execute arbitrary commands inside the Kafka container.
# Accepts any command as arguments and runs it within the Kafka container.
# See below for Usage instructions.

# To exit on first error in the script.
set -e

# Usage instructions:
# Usage: ./kafka-exec.sh <command> [args...]
# Example: ./kafka-exec.sh ls -ld /var/lib/kafka/data

# Execute the command passed as arguments
docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml exec kafka "$@"
