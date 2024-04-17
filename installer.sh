#!/bin/bash

# Variables
DOCKER_COMPOSE_FILE="docker-compose.yml"
# ADD GITHUB TOKEN
# ADD GITHUB USERNAME

# Login to GitHub Container Registry
docker login ghcr.io -u $GITHUB_USERNAME -p $GITHUB_TOKEN

# Pull images from GitHub Container Registry
docker-compose -f $DOCKER_COMPOSE_FILE pull

# Run Docker Compose
docker-compose -f $DOCKER_COMPOSE_FILE up -d
