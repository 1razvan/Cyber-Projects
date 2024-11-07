#!/bin/bash

##### Repeated run script #####


##### Kill existing containers #####
echo "##### KILLING EXISTING CONTAINERS #####"
docker kill iss2023-bravo-4-db-stripped_c
docker kill iss2023-bravo-4-web-stripped_c
echo "##########"
echo ""


##### Run database server #####
##### As user mysql, with all security options and capabilities in place #####
echo "##### RUNNING SECURE & PERSISTENT DBSERVER CONTAINER #####"
cd ../builds/dbserver/
docker run -d --rm --net iss2023/bravo-4_n \
--ip 198.51.100.150 \
--hostname db.iss.cyber23.test \
-e MARIADB_INITDB_SKIP_TZINFO="true" \
--name iss2023-bravo-4-db-stripped_c \
--security-opt label:type:docker_dbserver-service_t \
--security-opt seccomp:docker_dbserver-service.json \
--cap-drop=ALL \
--cap-add=SETGID \
--cap-add=SETUID \
--cap-add=CHOWN \
-v bravo-4-db-volume:/var/lib:rw,z \
--user mysql \
iss2023/bravo-4-db-stripped_i
echo "##########"
echo ""


##### Run website server #####
##### With all security options and capabilities in place #####
echo "##### RUNNING SECURE WEBSERVER CONTAINER #####"
cd ../webserver/
docker run -d --rm --net iss2023/bravo-4_n \
--ip 198.51.100.149 \
--hostname www.iss.cyber23.test \
--add-host db.iss.cyber23.test:198.51.100.150 \
-p 8080:80 --name iss2023-bravo-4-web-stripped_c \
--security-opt label:type:docker_webserver-service_t \
--security-opt seccomp:docker_webserver-service.json \
--cap-drop=ALL \
--cap-add=CHOWN \
--cap-add=NET_BIND_SERVICE \
--cap-add=SETGID \
--cap-add=SETUID \
iss2023/bravo-4-web-stripped_i
echo "##########"
echo ""



