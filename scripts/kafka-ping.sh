#!/bin/bash
# Script to ping Kafka or another specified service to check connectivity.
# Accepts optional service and target parameters; defaults to pinging Kafka.
# See below for Usage instructions.

# To exit on first error in the script.
set -e

# Default service and target
DEFAULT_SERVICE="kafka"
DEFAULT_TARGET="kafka"

# Usage instructions
if [ "$1" == "--help" ]; then
  echo "Usage: $0 [<service> <target>]"
  echo "Examples:"
  echo "  $0                 # Pings the default Kafka service"
  echo "  $0 kafka kafka-1   # Pings 'kafka-1' from the 'kafka' service"
  echo "  $0 zookeeper kafka # Pings 'kafka' from the 'zookeeper' service"
  exit 0
fi

# Set service and target based on input or use defaults
SERVICE=${1:-$DEFAULT_SERVICE}
TARGET=${2:-$DEFAULT_TARGET}

# Execute ping command
echo "Pinging $TARGET from $SERVICE..."
docker compose -f docker/docker-compose.yml exec "$SERVICE" ping -c 4 "$TARGET"
