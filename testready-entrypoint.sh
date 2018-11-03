#!/bin/bash
echo "[KEYCLOAK TESTREADY] Started"

# Wait for database (if required)

if [[ ! -z $WAIT_FOR_DB ]]; then
	if [[ "$DB_VENDOR" == "POSTGRES" ]]; then
		timeout $WAIT_FOR_SECONDS bash -c 'until echo > /dev/tcp/$POSTGRES_PORT_5432_TCP_ADDR/$POSTGRES_PORT_5432_TCP_PORT; do sleep 0.5; done'
	fi
	if [[ "$DB_VENDOR" == "MYSQL" ]]; then
		timeout $WAIT_FOR_SECONDS bash -c 'until echo > /dev/tcp/$MYSQL_PORT_3306_TCP_ADDR/$MYSQL_PORT_3306_TCP_PORT; do sleep 0.5; done'
	fi
fi


# Copy the content of the environment variable IMPORT_JSON into a file
# and execute the original entry point with or without import argument

if [[ ! -z $IMPORT_JSON ]]; then
	echo "[KEYCLOAK TESTREADY] Found some JSON to import"
    IMPORT_JSON_FILE=/opt/jboss/keycloak/bin/import-realm.json
    echo "$IMPORT_JSON" > $IMPORT_JSON_FILE
    chown jboss:jboss $IMPORT_JSON_FILE
    exec /opt/jboss/tools/docker-entrypoint.sh -Dkeycloak.import=$IMPORT_JSON_FILE $@
else
	echo "[KEYCLOAK TESTREADY] No IMPORT_JSON defined"
    exec /opt/jboss/tools/docker-entrypoint.sh $@
fi
exit $?
