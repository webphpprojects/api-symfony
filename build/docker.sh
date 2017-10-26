#!/bin/bash

#Get .env file
source .env

#Get current dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
export WEB_DIR="${PWD}/.."

#Go to docker directory
cd $DIR/build

#docker-compose up -d --build
docker-compose -f docker-compose.yml -p api up -d