#!/bin/bash
source .env

# Compilación de la imagen
docker build -t docker.io/pepesan/cuenta-atras:latest .
docker build -t docker.io/pepesan/cuenta-atras:1.0 .

# Login Registry (Docker Hub)
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

# Subida de la imagen
docker push docker.io/pepesan/cuenta-atras:latest
docker push docker.io/pepesan/cuenta-atras:1.0

# lanzamiento local
# docker run --rm  -p 3001:3000 docker.io/pepesan/cuenta-atras
