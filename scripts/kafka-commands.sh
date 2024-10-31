#!/bin/bash

# Common docker compose command prefix
COMPOSE_BASE="docker compose -f docker/docker-compose.yml -f docker/docker-compose.kafka.yml"

echo "Kafka Pipeline Commands Reference"
echo "================================="
echo
echo "1. Start Services (detached mode):"
echo "   - Starts Kafka, Zookeeper, and related services in detached mode."
echo "$COMPOSE_BASE up -d"
echo
echo "2. Stop Services:"
echo "   - Stops all running services defined in the Docker Compose files."
echo "$COMPOSE_BASE down"
echo
echo "3. Stop and Remove Volumes:"
echo "   - Stops services and removes all associated Docker volumes to clear data."
echo "$COMPOSE_BASE down -v"
echo
echo "4. View All Logs (continuous):"
echo "   - Streams logs for all services in real-time."
echo "$COMPOSE_BASE logs -f"
echo
echo "5. View Logs for Specific Service (e.g., Kafka or Zookeeper):"
echo "   - Streams logs only for the specified service."
echo "$COMPOSE_BASE logs -f kafka"
echo "$COMPOSE_BASE logs -f zookeeper"
echo "$COMPOSE_BASE logs -f kafka-data-generator"
echo
echo "6. Check Service Status:"
echo "   - Displays the status of all services, showing which are up or stopped."
echo "$COMPOSE_BASE ps"
echo
echo "7. Start Services (with console output):"
echo "   - Starts services with console output for monitoring startup process."
echo "$COMPOSE_BASE up"
echo
echo "8. Restart Specific Service (e.g., Kafka):"
echo "   - Restarts a specific service within the Docker Compose setup."
echo "$COMPOSE_BASE restart kafka"
echo
echo "9. View Resource Usage:"
echo "   - Shows CPU, memory, and other resource usage for each service container."
echo "$COMPOSE_BASE top"
echo
echo "10. Execute Command in Kafka Container:"
echo "   - Executes a command inside the Kafka container (e.g., list topics)."
echo "$COMPOSE_BASE exec kafka kafka-topics.sh --bootstrap-server localhost:9092 --list"
echo
echo "11. Execute Command in Kafka Container with scripts/utils/kafka-exec.sh:"
echo "   - Usage: scripts/utils/kafka-exec.sh <command> [args...]"
echo "   - Runs any command inside the Kafka container, such as listing files or checking Kafka configurations."
echo "   - Example (generic command):"
echo "     ./scripts/utils/kafka-exec.sh ls -ld /var/lib/kafka/data"
echo "   - Example (Kafka command, specifying --bootstrap-server explicitly):"
echo "     ./scripts/utils/kafka-exec.sh kafka-topics.sh --bootstrap-server localhost:9092 --list"
echo 
echo "12. View Docker Compose Configuration:"
echo "   - Displays the active configuration by merging all Docker Compose files."
echo "$COMPOSE_BASE config"
echo 
echo "13" ps commands
echo docker ps -a         This command shows you only the containers that are currently running. It's the simplest and quickest way to see what's active.

echo
echo "End of Commands"

This command shows you only the containers that are currently running. It's the simplest and quickest way to see what's active.
To View All Containers (Running and Stopped):

docker ps -a    

This command lists all containers, including those that are not running. It's useful if you're looking for containers that might have crashed or been stopped.
