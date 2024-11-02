#!/bin/bash

# Wait for My Python Producer to be ready
while ! nc -z producer 9093; do
    echo "waiting for My Python Producer to be ready..."
    sleep 1
done
echo "My Python Producer is ready"