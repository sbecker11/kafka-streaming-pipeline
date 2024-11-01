#!/bin/bash

while ! nc -z localhost 9092; do
    echo "waiting for Kafka to be ready..."
    sleep 1
done
echo "Kafka is ready"