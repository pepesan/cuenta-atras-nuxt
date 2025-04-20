#!/bin/bash
source .env

docker build -t docker.io/pepesan/cuenta-atras:latest .
docker build -t docker.io/pepesan/cuenta-atras:1.0 .

docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

docker push docker.io/pepesan/cuenta-atras:latest
docker push docker.io/pepesan/cuenta-atras:1.0
# docker run --rm  -p 3001:3000 docker.io/pepesan/cuenta-atras
