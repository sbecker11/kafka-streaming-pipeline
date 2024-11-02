#!/bin/bash
set -e

SERVICE_NAME=$1
SERVICE_PORT=$2

echo "CHECK GROK NOTES FOR SUGGESTED CHANGES"

# Wait for the service to be ready
while ! nc -z ${SERVICE_NAME} ${SERVICE_PORT}; do
    echo "waiting for ${SERVICE_NAME} to be ready on port ${SERVICE_PORT}..."
    sleep 1
done
echo "${SERVICE_NAME} is ready on port ${SERVICE_PORT}"