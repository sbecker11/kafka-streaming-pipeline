#!/bin/bash
set -e

check_port() {
    local port=$1
    if lsof -i ":$port" > /dev/null 2>&1; then
        echo "Port $port is in use"
        lsof -i ":$port"
        return 1
    else
        echo "Port $port is available"
        return 0
    fi
}

echo "Checking required ports..."
check_port 2181  # Zookeeper
check_port 9092  # Kafka internal
check_port 29092 # Kafka external
check_port 9093  # Python producer
Last edited 10 minutes ago


