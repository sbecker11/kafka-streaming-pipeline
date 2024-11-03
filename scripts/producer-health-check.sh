#!/bin/bash
set -e

# Check if the producer process is running
if pgrep -f "python /app/producer.py" > /dev/null; then
    exit 0
else
    exit 1
fi