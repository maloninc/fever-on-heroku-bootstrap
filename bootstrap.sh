#!/bin/sh
set -e

APP_NAME=$1

# Initialize git repo for Fever
mkdir -p fever
cd fever
git init .

# Download Fever source code and expand it
curl -s -O http://feedafever.com/gateway/public/fever.zip
unzip -q fever.zip -d . && rm fever.zip
echo '<meta http-equiv="refresh" content="3;URL=/fever/boot.php">' > index.php

# Download maintenance scripts
curl -s -O https://raw.githubusercontent.com/maloninc/fever-on-heroku-bootstrap/master/purge.php
curl -s -O https://raw.githubusercontent.com/maloninc/fever-on-heroku-bootstrap/master/refresh.sh

# First commit
git add -A .
git commit -m "First commit."

# Set up heroku app with custome build pack for PHP
echo ""
echo ""
heroku login
heroku create ${APP_NAME} -s cedar -b git://github.com/iphoting/heroku-buildpack-php-tyler.git
heroku addons:add cleardb:ignite
heroku addons:add scheduler:standard
git push heroku master


# Show Database Info
echo ""
echo ""
echo "Here is MySQL database credential"
echo "========================================"
heroku config | \
grep CLEARDB_DATABASE_URL | \
cut -d " " -f2 | \
php -r '$conn=""; $in=fopen("php://stdin", "r"); while(!feof($in)){ $conn=$conn . fgets($in, 4096); } print_r(parse_url($conn));' | \
tr -d '/' 
echo "========================================"


# Show additional actions
echo ""
echo ""
echo "==== Additional actions ===="
echo ""
echo "[Setup Automatic Refresh, Re-activation and Purge]"
echo "To set up automatic refresh, run the following command. It will open Heroku Scheduler website."
echo ""
echo "    heroku addons:open scheduler"
echo ""
echo "Then enter the following command to the command field, and configure it as per-10-miniutes job."
echo ""
echo "    ./refresh.sh http://<YOUR-HEROKU-APP>/ <FEVER-ACTIVATION-KEY> <DB_SERVER_NAME> <DB_NAME> <USERNAME> <PASSWORD>"
echo ""
echo ""

# Open launch page
heroku open