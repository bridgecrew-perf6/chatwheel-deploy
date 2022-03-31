#!/usr/bin/env bash

# Building the frontend
echo -n 'Building a new version of the frontend application...'
echo -en '\n'
  # Get the latest version of the code from the git repository https://github.com/pavelkolomitkin/chatwheel-frontend.git
    # If the directory ./frontend_src exists -> pull the latest changes from the main branch
    # else clone the whole repository to the ./frontend_src directory
echo -en '\n'
echo 'Pull the source code...'
echo -en '\n'
if [[ ! -d ./frontend_src/ ]]
then
    git clone https://github.com/pavelkolomitkin/chatwheel-frontend.git frontend_src
fi

cd ./frontend_src && git pull origin main && cd ..

  # Remove the existing wisecat/frontend-app-build-tool docker image
docker image rm wisecat/frontend-app-build-tool
  # Build a new docker image using docker/frontend-app-build-tool.docker file tagging it as wisecat/frontend-app-build-tool
docker build --no-cache -t wisecat/frontend-app-build-tool -f docker/frontend-app-build-tool.docker .

  # Build the angular app
    # Install npm packages using the docker image wisecat/frontend-app-build-tool
docker run --rm -v $(pwd)/frontend_src/app:/app -w /app wisecat/frontend-app-build-tool npm install
    # Build the application itself using the docker image wisecat/frontend-app-build-tool
docker run --rm -v $(pwd)/frontend_src/app:/app -w /app wisecat/frontend-app-build-tool ng build --prod --aot --build-optimizer

  # Remove the existing image with the tag wisecat/chatwheel-frontend
docker image rm wisecat/chatwheel-frontend
  # Build a new image using the docker file ./docker/frontend-app.docker getting it tagged with wisecat/chatwheel-frontend
docker build --no-cache -t wisecat/chatwheel-frontend -f docker/frontend-app.docker .
    # It should be based on nginx image(see the backend docker compose file)
    # Copy the nginx file to the image
    # Copy the built angular application to the image
    # Create swarm secrets necessary to pass it over to the frontend service
      # secrets for ssl keys


