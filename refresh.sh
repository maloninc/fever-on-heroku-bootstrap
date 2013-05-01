#!/bin/sh

BASE_URL=$1
ACTIVATION_KEY=$2
DB_SERVER=$3
DB_DATABASE=$4
DB_USERNAME=$5
DB_PASSWORD=$6

curl -s ${BASE_URL}/fever/boot.php > /dev/null

sleep 5

curl -s ${BASE_URL}/fever/?passed > /dev/null

curl -s \
     -d activation_key=${ACTIVATION_KEY} \
     -d accept_eula=on \
     ${BASE_URL}/fever/ > /dev/null

curl -s \
     -d action=database \
     -d db_server=${DB_SERVER} \
     -d db_database=${DB_DATABASE} \
     -d db_username=${DB_USERNAME} \
     -d db_password=${DB_PASSWORD} \
     -d db_prefix=fever_ \
     -d db_prefix_alt=fever_ \
     -d db_option=2 \
     ${BASE_URL}/fever/ > /dev/null

curl -Ls ${BASE_URL}/fever/?refresh

php ./purge.php ${DB_SERVER} ${DB_DATABASE} ${DB_USERNAME} ${DB_PASSWORD}
