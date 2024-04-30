#!/bin/bash
DOCKER_COMPOSE_FILE="docker-compose.yml"

# Stop and remove all running containers
docker-compose -f $DOCKER_COMPOSE_FILE down

# Remove Docker networks related to the application
docker network rm $(docker network ls --filter name=SensorSync -q)

# Remove Docker images related to the application
docker image rm -f $(docker image ls --filter reference='ghcr.io/magnusquist/*' -q)
docker image rm -f $(docker image ls --filter reference='ghcr.io/dunkykanstrup/*' -q)
docker image rm -f $(docker image ls --filter reference='ghcr.io/helleberg/*' -q)
docker image rm -f postgres
