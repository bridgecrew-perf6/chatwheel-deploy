#!/usr/bin/env bash

  # Remove the existing image with the tag wisecat/chatwheel-backend
docker image rm wisecat/chatwheel-update-service-message
  # Build the new version of the backend application with the ./docker/backend-app.docker getting it tagged with wisecat/chatwheel-backend
docker build --no-cache -t wisecat/chatwheel-update-service-message -f docker/update-service-message.docker .