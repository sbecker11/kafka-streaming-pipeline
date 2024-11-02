#!/bin/bash

while ! nc -z localhost 9092; do
    echo "waiting for kafka to be ready..."
    sleep 1
done
echo "kafka is ready"