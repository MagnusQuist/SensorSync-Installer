#!/bin/bash

# Variables
DOCKER_COMPOSE_FILE="docker-compose.yml"

# Pull images from GitHub Container Registry
echo "Pulling Docker images..."
docker-compose -f "$DOCKER_COMPOSE_FILE" pull
if [ $? -ne 0 ]; then
    echo "Error: Failed to pull Docker images."
    exit 1
fi

# Run Docker Compose
echo "Starting Docker containers..."
docker-compose -f "$DOCKER_COMPOSE_FILE" up -d
if [ $? -ne 0 ]; then
    echo "Error: Failed to start Docker containers."
    exit 1
fi

# Add a delay to ensure services are up (adjust the sleep duration if needed)
echo "Waiting for services to start..."
sleep 10

echo "################################################"
echo "# Dashboard: http://localhost:8080             #"
echo "################################################"
