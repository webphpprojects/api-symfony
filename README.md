Symfony API - RESTful API based on Symfony 3.3
=============

## Prepare environment
1. Edit build/.env - change PROJECT_NAME and MYSQL_DATABASE (optional)
2. Edit build/docker.sh - set project name you put in first step (optional, required if you change name in first step)
3. Check build/docker-compose.yml - be sure that port for each container is not used in your system
4. Go to build and run ./docker.sh
5. Run `docker exec -ti api_php bash` or if you changed project name: `docker exec -ti your_container_name bash`
6. Run `composer install`.
7. Generate the SSH keys for LexikJWTAuthenticationBundle:

````
$ mkdir -p var/jwt # For Symfony3+, no need of the -p option
$ openssl genrsa -out var/jwt/private.pem -aes256 4096
$ openssl rsa -pubout -in var/jwt/private.pem -out var/jwt/public.pem
````
And update this: ``jwt_key_pass_phrase`` in parameters.yml - set pass phrase you type a few seconds ago

## Create database:
````
php bin/console doctrine:database:create
php bin/console doctrine:database:create --env=acceptance

php bin/console doctrine:schema:update --force
php bin/console doctrine:schema:update --force --env=acceptance
````

Optionally you can run:
`php bin/console fos:user:create` and `php bin/console fos:user:create -e=acceptance` for creating uer for both database

## Run Behat tests:
`php vendor/bin/behat`