#!/bin/sh
 set -e

if kafka-topics --bootstrap-server localhost:9092 --list | grep -q "^user-login$"; then
  echo "Topic 'user-login' already exists"
fi
exit 0

# Wait for Kafka to be ready
while ! nc -z localhost 9092; do
    echo "waiting for Kafka to be ready..."
    sleep 1
done

# Create topics
kafka-topics --bootstrap-server localhost:9092 --create --topic user-login --replication-factor 1 --partitions 1
echo "Topic 'user-login' created"

# this requires the kafka container to be running
# docker compose -f docker/docker-compose.yml exec kafka /usr/bin/kafka-topics --bootstrap-server localhost:9092 --create --topic user-login  --partitions 1 --replication-factor 1
