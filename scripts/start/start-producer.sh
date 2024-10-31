#!/bin/bash

PRODUCER_PORT=9093

# Function to check if port is available
check_port() {
    ./scripts/utils/check-port.sh "$1" | grep -q "Available"
}

# Function to handle port conflicts
handle_conflict() {
    echo "Port $PRODUCER_PORT in use. Choose action:"
    echo "1. Kill process  2. Exit"
    read choice
    case $choice in
        1) 
            kill $(lsof -i :$PRODUCER_PORT | grep LISTEN | awk '{print $2}') && \
            check_port $PRODUCER_PORT
            ;;
        *) return 1 ;;
    esac
}

# Check if port is available, handle conflict if not
if ! check_port $PRODUCER_PORT && ! handle_conflict; then
    echo "Failed to secure port or user chose to exit."
    exit 1
fi

# Target logic: Start the producer
docker compose -f docker/docker-compose.yml up -d my-python-producer