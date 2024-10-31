#!/bin/bash

# Start everything
docker-compose -f docker/docker-compose.yml \
               -f docker/docker-compose.kafka.yml \
               -f docker/docker-compose.monitor.yml \
               -f docker/docker-compose.app.yml up -d

# Start only Kafka components
docker-compose -f docker/docker-compose.yml \
               -f docker/docker-compose.kafka.yml up -d

# Start only monitoring
docker-compose -f docker/docker-compose.yml \
               -f docker/docker-compose.monitor.yml up -d