#!/bin/bash

##### One-off run config script #####


##### Adding SELinux policies #####
# Adding the database server SELinux policy
echo "##### INSTALLING THE DBSERVER SELINUX POLICY #####"
cd ../builds/dbserver/
sudo make -f /usr/share/selinux/devel/Makefile docker_dbserver-service.pp
sudo semodule -i docker_dbserver-service.pp
sudo semodule -l | grep docker_dbserver-service
echo "##########"
echo ""

# Adding the website server SELinux policy
echo "##### INSTALLING THE WEBSERVER SELINUX POLICY #####"
cd ../webserver/
sudo make -f /usr/share/selinux/devel/Makefile docker_webserver-service.pp
sudo semodule -i docker_webserver-service.pp
sudo semodule -l | grep docker_webserver-service
echo "##########"
echo ""


##### Creating database persistent volume #####
# Removing existing database volume
echo "##### REMOVING LEFTOVER DATABASE VOLUME #####"
docker volume rm bravo-4-db-volume
echo "##########"
echo ""

# Creating database volume
echo "##### CREATING NEW DATABASE VOLUME #####"
docker volume create bravo-4-db-volume
echo "##########"
echo ""


##### Initialising database #####
# Running database once to import data
echo "##### RUNNING DBSERVER AS ROOT FOR INITIALISATION #####"
cd ../dbserver/
docker run -d --rm --net iss2023/bravo-4_n \
--ip 198.51.100.150 \
--hostname db.iss.cyber23.test \
-e MYSQL_ROOT_PASSWORD="CorrectHorseBatteryStaple-xkcd" \
-e MYSQL_DATABASE="iss2023db" \
-e MARIADB_INITDB_SKIP_TZINFO="true" \
--name iss2023-bravo-4-db-stripped_c \
--security-opt label:type:docker_dbserver-service_t \
--cap-drop=ALL \
--cap-add=SETGID \
--cap-add=SETUID \
--cap-add=CHOWN \
-v bravo-4-db-volume:/var/lib:rw,z \
iss2023/bravo-4-db-stripped_i
echo "##########"
echo ""

# Importing SQL database dump
echo "##### INITIALISING ISS2023 DATABASE #####"
sleep 4
docker exec -i iss2023-bravo-4-db-stripped_c mysql -uroot -pCorrectHorseBatteryStaple-xkcd < sqlconfig/iss2023db.sql
echo "##########"
echo ""

# Kill database container
echo "##### KILLING ROOT DBSERVER CONTAINER #####"
docker kill iss2023-bravo-4-db-stripped_c
echo "##########"
echo ""

# Run the persistent container one time, as user mysql, to fix permissions
echo "##### RUNNING NON-ROOT DBSERVER WITH PERSISTENT VOLUME TO FIX PERMISSIONS #####"
docker run -d --rm --net iss2023/bravo-4_n \
--ip 198.51.100.150 \
--hostname db.iss.cyber23.test \
-e MARIADB_INITDB_SKIP_TZINFO="true" \
--name iss2023-bravo-4-db-stripped_c \
--security-opt label:type:docker_dbserver-service_t \
--cap-drop=ALL \
--cap-add=SETGID \
--cap-add=SETUID \
--cap-add=CHOWN \
-v bravo-4-db-volume:/var/lib:rw \
--user mysql \
iss2023/bravo-4-db-stripped_i
echo "##########"
echo ""

# Kill database container
echo "##### KILLING NON-ROOT DBSERVER CONTAINER #####"
docker kill iss2023-bravo-4-db-stripped_c
echo "##########"
echo ""

