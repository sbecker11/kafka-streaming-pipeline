#!/bin/bash
# full-precheck
# This script performs a full system check to verify the Kafka streaming pipeline's environment, including directory structures, required files, Docker Compose configurations, environment variables, network configurations, and script permissions.

set -e


# Function to detect Docker Compose command
get_docker_compose_cmd() {
    # Checks for availability of Docker Compose (either as a plugin or standalone)
    if command -v docker &> /dev/null; then
        if docker compose version &> /dev/null; then
            echo "docker compose"
        elif command -v docker-compose &> /dev/null; then
            echo "docker-compose"
        fi
    fi
}

echo "Starting full system pre-check for Kafka pipeline setup..."

# Check required directories and create them if missing
echo -e "\nChecking required directories..."
DIRECTORIES=(
    "docker"
    "src/consumer"
    "scripts/utils"
    "data"
    # "config/prometheus/alerts"
    # "config/grafana/dashboards"
    # "config/grafana/datasources"
)
for dir in "${DIRECTORIES[@]}"; do
    if [ ! -d "$dir" ]; then
        echo "Creating directory: $dir"
        mkdir -p "$dir"
    else
        echo "✓ Directory exists: $dir"
    fi
done

# Check for required Docker Compose files and confirm their existence
echo -e "\nChecking required Docker Compose files..."
DOCKER_FILES=(
    "docker/docker-compose.yml"
    "docker/docker-compose.kafka.yml"
    "docker/docker-compose.app.yml"
)
for file in "${DOCKER_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ File exists: $file"
    else
        echo "✗ Missing file: $file"
        exit 1
    fi
done

# Validate Docker Compose syntax to ensure configurations are correct
DOCKER_COMPOSE_CMD=$(get_docker_compose_cmd)
if [ -z "$DOCKER_COMPOSE_CMD" ]; then
    echo "✗ Docker Compose is not available"
    echo "Please install Docker Desktop or Docker Compose"
    exit 1
fi

echo "Using Docker Compose command: $DOCKER_COMPOSE_CMD"
echo -e "\nVerifying Docker Compose configuration syntax..."
if $DOCKER_COMPOSE_CMD -f docker/docker-compose.yml \
                       -f docker/docker-compose.kafka.yml \
                       -f docker/docker-compose.app.yml config; then
    echo "✓ Docker Compose configuration is valid"
else
    echo "✗ Docker Compose configuration contains errors"
    exit 1
fi

# Verify custom network presence, creating it if missing
NETWORK_NAME="kafka-network"
if ! docker network ls | grep -q "$NETWORK_NAME"; then
    echo "✗ Network $NETWORK_NAME is missing. Creating it..."
    docker network create "$NETWORK_NAME"
else
    echo "✓ Network $NETWORK_NAME exists"
fi

# Check that key scripts have executable permissions
echo -e "\nChecking script permissions for executable files..."
SCRIPTS=(
    "scripts/start/start-kafka.sh"
    "scripts/stop/stop-kafka.sh"
    "scripts/utils/kafka-exec.sh"
    "scripts/utils/kafka-ping.sh"
    "scripts/utils/kafka-log.sh"
    "scripts/utils/full-precheck.sh"  # This script
    "scripts/utils/full-cleanup.sh"
    "scripts/utils/full-rebuild.sh"
)
for script in "${SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        if [ ! -x "$script" ]; then
            echo "Setting executable permission for $script"
            chmod +x "$script"
        fi
        echo "✓ Script is executable: $script"
    else
        echo "✗ Missing script: $script"
    fi
done

echo -e "\nFull system pre-check complete! The environment is ready for Kafka and Zookeeper startup."
