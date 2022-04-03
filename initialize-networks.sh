#!/usr/bin/env bash

# WARNING! It should be run only once on the master node

echo -en '\n'
echo -n 'Create the backend network...'
echo -en '\n'
docker network create -d overlay chatwheel-backend-network

echo -en '\n'
echo -n 'Create the frontend network...'
echo -en '\n'
docker network create -d overlay chatwheel-frontend-network