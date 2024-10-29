#!/bin/bash

# Common docker compose command prefix
COMPOSE_BASE="docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml"

echo "Kafka Pipeline Commands Reference"
echo "================================"
echo
echo "Start Services:"
echo "$COMPOSE_BASE up -d"
echo
echo "Stop Services:"
echo "$COMPOSE_BASE down"
echo
echo "Stop and Remove Volumes:"
echo "$COMPOSE_BASE down -v"
echo
echo "View All Logs:"
echo "$COMPOSE_BASE logs -f"
echo
echo "View Specific Logs:"
echo "$COMPOSE_BASE logs -f kafka"
echo "$COMPOSE_BASE logs -f zookeeper"
echo "$COMPOSE_BASE logs -f kafka-data-generator"
echo
echo "Check Service Status:"
echo "$COMPOSE_BASE ps"
echo
echo "Start Services (with console output):"
echo "$COMPOSE_BASE up"
echo
echo "Restart Specific Service:"
echo "$COMPOSE_BASE restart kafka"
echo
echo "View Resource Usage:"
echo "$COMPOSE_BASE top"
echo
echo "Execute Command in Container:"
echo "$COMPOSE_BASE exec kafka kafka-topics.sh --bootstrap-server localhost:9092 --list"
echo
echo "View Container Configuration:"
echo "$COMPOSE_BASE config"
