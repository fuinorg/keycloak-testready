#!/bin/bash
echo "[KEYCLOAK TESTREADY] Started"

# Wait for database (if required)

if [[ -z "$DB_VENDOR" ]]; then
    echo "Please provide DB_VENDOR as environment variable" 1>&2
    exit 1
fi

if [[ ! -z $WAIT_FOR_DB ]]; then
	timeout $WAIT_FOR_SECONDS bash -c 'until echo > /dev/tcp/$DB_ADDR/$DB_PORT; do sleep 0.5; done'
fi

echo "Database connection is finally available..." 1>&2

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
