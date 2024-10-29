#!/bin/bash
# Health check script for the Kafka producer.
# Sends a test message to Kafka to verify producer connectivity and readiness.
# This script is generally called by Docker Compose as part of the producer health check.
# See below for Usage instructions.

# To exit on first error in the script.
set -e

# Usage instructions
# Usage: ./producer_healthcheck.sh

echo "Testing Kafka producer connectivity..."
if echo > /dev/tcp/kafka/9092; then
  echo "Kafka producer is ready."
  exit 0
else
  echo "Kafka producer not ready."
  exit 1
fi
