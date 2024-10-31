#!/bin/bash

# Check if a port is available
check_port() {
    local port=$1
    if lsof -i ":$port" > /dev/null 2>&1; then
        echo "In Use"
    else
        echo "Available"
    fi
}

# Ensure a port number is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <port_number>"
    exit 1
fi

check_port $1