#!/bin/sh
set -e

APP_NAME=$1

# Initialize git repo for Fever
mkdir -p fever
cd fever
git init .

# Download Fever source code and expand it
curl -O http://feedafever.com/gateway/public/fever.zip
unzip fever.zip -d . && rm fever.zip
touch index.php

# First commit
git add -A .
git commit -m "Added Fever bootstrap code, Heroku index.php"

# Set up heroku app with custome build pack for PHP
heroku login
heroku create "${APP_NAME}" -s cedar -b git://github.com/iphoting/heroku-buildpack-php-tyler.git
heroku addons:add cleardb:ignite
git push heroku master


# Show Database Info
echo "Here is MySQL database credential"
heroku config | grep CLEARDB_DATABASE_URL | cut -d " " -f2 | php -r '$conn=""; $in=fopen("php://stdin", "r"); while(!feof($in)){ $conn=$conn . fgets($in, 4096); } print_r(parse_url($conn));'

# Open launch page
open "http://${APP_NAME}.herokuapp.com/fever/boot.php"