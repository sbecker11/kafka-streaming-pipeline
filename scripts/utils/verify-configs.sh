#!/bin/bash

# Set script to exit on any error
set -e

# Function to detect docker compose command
get_docker_compose_cmd() {
    if command -v docker &> /dev/null; then
        if docker compose version &> /dev/null; then
            echo "docker compose"
        elif command -v docker-compose &> /dev/null; then
            echo "docker-compose"
        else
            echo ""
        fi
    else
        echo ""
    fi
}

echo "Verifying project configuration..."

# Function to create directory if it doesn't exist
create_dir_if_missing() {
    if [ ! -d "$1" ]; then
        echo "Creating directory: $1"
        mkdir -p "$1"
    else
        echo "✓ Directory exists: $1"
    fi
}

# Function to check file existence
check_file() {
    if [ -f "$1" ]; then
        echo "✓ File exists: $1"
    else
        echo "✗ Missing file: $1"
        return 1
    fi
}

echo -e "\nChecking directory structure..."
DIRECTORIES=(
    "docker"
    "config/prometheus/alerts"
    "config/grafana/dashboards"
    "config/grafana/datasources"
    "src/consumer"
    "scripts/utils"
    "data"
)

for dir in "${DIRECTORIES[@]}"; do
    create_dir_if_missing "$dir"
done

echo -e "\nChecking Docker Compose files..."
DOCKER_FILES=(
    "docker/docker-compose.yml"
    "docker/docker-compose.kafka.yml"
    "docker/docker-compose.monitor.yml"
    "docker/docker-compose.app.yml"
)

for file in "${DOCKER_FILES[@]}"; do
    check_file "$file"
done

echo -e "\nVerifying Docker Compose syntax..."
DOCKER_COMPOSE_CMD=$(get_docker_compose_cmd)

if [ -z "$DOCKER_COMPOSE_CMD" ]; then
    echo "✗ Neither 'docker compose' nor 'docker-compose' commands are available"
    echo "Please install Docker Desktop or Docker Compose separately"
    exit 1
fi

echo "Using command: $DOCKER_COMPOSE_CMD"

if $DOCKER_COMPOSE_CMD -f docker/docker-compose.yml \
                      -f docker/docker-compose.kafka.yml \
                      -f docker/docker-compose.monitor.yml \
                      -f docker/docker-compose.app.yml config; then
    echo "✓ Docker Compose configuration is valid"
else
    echo "✗ Docker Compose configuration has errors"
    exit 1
fi

echo -e "\nConfiguration verification complete!"
