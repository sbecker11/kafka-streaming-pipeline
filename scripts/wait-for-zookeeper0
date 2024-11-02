#!/bin/bash

# Wait for zookeeper to be ready
while ! nc -z zookeeper 2181; do
    echo "waiting for zookeeper to be ready..."
    sleep 1
done
echo "zookeeper is ready"