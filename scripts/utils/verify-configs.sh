#!/bin/bash
# Script to verify the configuration of the Kafka streaming pipeline.
# Checks required directories, files, and Docker Compose syntax.
# Outputs missing elements and verifies that Docker Compose is installed.

# Usage: ./verify-configs.sh
# Optional: Pass --help for usage information

# Exit on first error in the script
set -e

# Detects the correct Docker Compose command
get_docker_compose_cmd() {
    if command -v docker &> /dev/null; then
        if docker compose version &> /dev/null; then
            echo "docker compose"
        elif command -v docker-compose &> /dev/null; then
            echo "docker-compose"
        fi
    fi
}

echo "Starting project configuration verification..."

# Function to create directory if missing
create_dir_if_missing() {
    if [ ! -d "$1" ]; then
        echo "Creating directory: $1"
        mkdir -p "$1"
    else
        echo "✓ Directory exists: $1"
    fi
}

# Function to check for file existence
check_file() {
    if [ -f "$1" ]; then
        echo "✓ File exists: $1"
    else
        echo "✗ Missing file: $1"
        return 1
    fi
}

# Help flag for usage instructions
if [ "$1" == "--help" ]; then
    echo "Usage: ./verify-configs.sh"
    echo "This script verifies the necessary directory structure, files, and Docker Compose syntax."
    exit 0
fi

echo -e "\nChecking required directories..."
DIRECTORIES=(
    "docker"
    "config/prometheus/alerts"
    "config/grafana/dashboards"
    "config/grafana/datasources"
    "src/consumer"
    "scripts/dev"
    "scripts/start"
    "scripts/stop"
    "scripts/utils"
    "data"
)

for dir in "${DIRECTORIES[@]}"; do
    create_dir_if_missing "$dir"
done

echo -e "\nChecking required Docker Compose files..."
DOCKER_FILES=(
    "docker/docker-compose.yml"
    "docker/docker-compose.kafka.yml"
    "docker/docker-compose.monitor.yml"
    "docker/docker-compose.app.yml"
)

for file in "${DOCKER_FILES[@]}"; do
    check_file "$file"
done

echo -e "\nValidating Docker Compose syntax..."
DOCKER_COMPOSE_CMD=$(get_docker_compose_cmd)

if [ -z "$DOCKER_COMPOSE_CMD" ]; then
    echo "✗ Docker Compose not found"
    echo "Please install Docker Desktop or Docker Compose"
    exit 1
fi

echo "Using Docker Compose command: $DOCKER_COMPOSE_CMD"

if $DOCKER_COMPOSE_CMD -f docker/docker-compose.yml \
                       -f docker/docker-compose.kafka.yml \
                       -f docker/docker-compose.monitor.yml \
                       -f docker/docker-compose.app.yml config; then
    echo "✓ Docker Compose configuration is valid"
else
    echo "✗ Docker Compose configuration contains errors"
    exit 1
fi

echo -e "\nConfiguration verification complete!"
