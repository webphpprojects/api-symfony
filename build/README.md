# Docker skeleton
This repo is part of docker skeleton (default for symfony)

## nginx build
This repo is the nginx build used for running a Symfony application.

## Configuration:
1. Set PROJECT_NAME in nginx/Dockerfile
2. Check if port set in docker-compose.yml for server and database is not used
3. Change volumes in data service
4. Run `docker-compose up -d`