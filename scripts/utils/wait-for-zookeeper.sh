#!/bin/bash

# Wait for Zookeeper to be ready
while ! nc -z zookeeper 2181; do
    echo "waiting for Zookeeper to be ready..."
    sleep 1
done
echo "Zookeeper is ready"