# keycloak-testready
A Keycloak docker image that allows adding a test realm with preconfigured users and clients

[![Automated Docker Build](https://img.shields.io/docker/automated/fuinorg/keycloak-testready.svg)](https://hub.docker.com/r/fuinorg/keycloak-testready/)

## Base Version

- Keycloak 3.3.0.CR2-3

## Usage

You can pass the JSON import file for your test realm using the environment variable **IMPORT_JSON**:

    docker run -it -e IMPORT_JSON="{\"realm\":\"tst\", ... }" <...more parameters...> fuinorg/cloudblue-testready

Your 'tst' realm is then imported and ready for use in your tests.

For an example of the JSON format see [keycloak-import-example.json](keycloak-import-example.json).

## Docker compose file

For your convenience there is also a [Docker Compose](https://docs.docker.com/compose/) file for [PostgreSQL](docker-compose-postgres.yml) and [MySQL](docker-compose-mysql.yml) to start a database and Keycloak together manually.  

**CAUTION**: You need to create an ".env" file in the same directory where the 'docker-compose-*.yml' files are located.

	dbRootPw=<password>
	dbName=keycloak
	dbUser=keycloak
	dbPassword=<password>
	keycloakUser=admin
	keycloakPassword=<password>

Just run:

    docker-compose -f ./docker-compose-postgres.yml up
   
or

	docker-compose -f ./docker-compose-mysql.yml up   
   
Now you can log into your Keycloak server at http://localhost:8088/ using the above defined credentials.

Shutdown with **CTRL C** and then run:

    docker-compose -f ./docker-compose-postgres.yml rm
   
or

	docker-compose -f ./docker-compose-mysql.yml rm   

This removes the stopped service containers.
