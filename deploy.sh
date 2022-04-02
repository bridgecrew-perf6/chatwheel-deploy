#!/usr/bin/env bash

# Stop the existing stack
echo -n 'Stop previous production stack...'
echo -en '\n'
docker stack rm chatwheel-production

/bin/bash ./build-backend.sh

/bin/bash ./build-frontend.sh


# Perform the database migrations - MANUALLY
    # Get the docker swarm up and run using the database-migrations-stack.yaml file
# docker stack deploy --compose-file docker/database-migrations-stack.yaml database-migration-stack
# reconfigure the replica set
  # authenticate on the server
  # config = rs.conf();
  # rs.reconfig(config, { force: true })
# Run the migration command from the service backend-app
#docker exec "$(docker ps -q -f name=node-app)" npm run migrate-mongo up
#docker exec "$(docker container ls | grep node-app | awk '{print $(NF)}' | head -n 1)" npm run migrate-mongo up
    # Shutdown the migration docker swarm stack
#docker stack rm database-migration-stack

# Get the new production stack up and run - MANUALLY
  # Get the docker swarm stack with the file ./docker/production-stack.yaml up and run
# docker stack deploy --compose-file docker/production-stack.yaml chatwheel-production
# DON'T FORGET TO AUTHENTICATE AND RECONFIGURE THE MONGODB SERVER
  # config = rs.conf();
  # rs.reconfig(config, { force: true })


# TODO make for the mongo database an individual stack that won't be affected by an ordinary deployment process
  # Create an external net with the name "backend" and the type "overlay"
  # Create an individual stack for the mongodb service with one replica
  # For the mongodb-service make the backend net available

  # Create an other stack with the rest services of the application
  # Make the backend net available for the node-app service

  # Create an external net with the name "frontend" and the type "overlay"
  # In the application stack make the frontend net available for both services "frontend" and "node-app"

  # Create an individual stack for database migrations
    # that will include the node-app service
    # the node-app should use the backend net
  # Create an individual script that gets up the database-migration stack and run migrations

  # Create an individual stack that consists of nginx service and is intended to show a message for users when
  # the app is being built up and unavailable for now

  # Rewrite the entire script this way
    # The application stack is being removed
    # The stack with the message is getting up
    # The building process is being conducted(pulling the source code and building new images)
    # The database-migrations stack is getting up and migrations are being run
    # The database-migrations stack is being removed
    # The application stack is getting up
    # The message stack is being removed
