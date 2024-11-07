#!/bin/bash

##### Build script for the web image and database image #####


##### Removing possible duplicates #####

# Kill and remove existing web container and image
echo "##### KILLING AND REMOVING EXISTING WEB CONTAINER AND IMAGE #####"
docker kill iss2023-bravo-4-web_c
docker rm iss2023-bravo-4-web_c
docker rmi iss2023/bravo-4-web_i
echo "##########"
echo ""

# Kill and remove existing web-stripped container and image
echo "##### KILLING AND REMOVING EXISTING WEB-STRIPPED CONTAINER AND IMAGE #####"
docker kill iss2023-bravo-4-web-stripped_c
docker rm iss2023-bravo-4-web-stripped_c
docker rmi iss2023/bravo-4-web-stripped_i
echo "##########"
echo ""

# Kill and remove existing database container and image
echo "##### KILLING AND REMOVING EXISTING DB CONTAINER AND IMAGE #####"
docker kill iss2023-bravo-4-db_c
docker rm iss2023-bravo-4-db_c
docker rmi iss2023/bravo-4-db_i
echo "##########"
echo ""

# Kill and remove existing database-stripped container and image
echo "##### KILLING AND REMOVING EXISTING DB-STRIPPED CONTAINER AND IMAGE #####"
docker kill iss2023-bravo-4-db-stripped_c
docker rm iss2023-bravo-4-db-stripped_c
docker rmi iss2023/bravo-4-db-stripped_i
echo "##########"
echo ""

# Remove existing network
echo "##### REMOVING EXISTING NETWORK #####"
docker network rm iss2023/bravo-4_n
echo "##########"
echo ""

##### Building images & creating network #####
# Creating network
echo "##### CREATING DOCKER NETWORK #####"
docker network create --subnet=198.51.100.0/24 iss2023/bravo-4_n
echo "##########"
echo ""

# Build web image, non-stripped
echo "##### BUILDING FULL WEB IMAGE #####"
docker build --tag iss2023/bravo-4-web_i ../builds/webserver/
echo "##########"
echo ""

# Build web-stripped image
echo "##### BUILDING STRIPPED WEB IMAGE #####"
cd ../builds/webserver && ./strip-cmd
echo "##########"
echo ""

# Build database image, non-stripped
echo "##### BUILDING FULL DB IMAGE #####"
docker build --tag iss2023/bravo-4-db_i ../dbserver/
echo "##########"
echo ""

# Build database-stripped image
echo "##### BUILDING STRIPPED DB IMAGE #####"
cd ../dbserver && ./strip-cmd
echo "##########"
echo ""

##### Removing unnecessary images #####
# Removing unstripped images
echo "##### REMOVING FULL IMAGES #####"
docker rmi iss2023/bravo-4-web_i
docker rmi iss2023/bravo-4-db_i
echo "##########"
echo ""

