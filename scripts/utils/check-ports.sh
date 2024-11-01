#!/bin/bash

# List of ports and their services
ports=(
    "2181:Zookeeper"
    "9092:Kafka internal"
    "29092:Kafka external"
    "9093:Python producer"
)

# Function to check and display port status
check_port_status() {
    local port=$1
    local service=$2
    status=$("./check-port.sh" $port)
    echo -e "$port\t$service\t($status)"
}

# Check each port
echo "Port\tService\tStatus"
for entry in "${ports[@]}"; do
    IFS=":" read -r port service <<< "$entry"
    check_port_status $port "$service"
done