#!/usr/bin/env bash

# Stop the existing stack
echo -n 'Stop previous production stack...'
echo -en '\n'
docker stack rm chatwheel-production

/bin/bash ./build-backend.sh

/bin/bash ./build-frontend.sh

# Get the new production stack up and run
  # Get the docker swarm stack with the file ./docker/production-stack.yaml up and run

