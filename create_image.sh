#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
source .env

IMAGE="docker.io/pepesan/cuenta-atras"

# Versión actual publicada (fichero VERSION, formato MAYOR.MINOR) y siguiente minor
CURRENT=$(tr -d '[:space:]' < VERSION)
MAJOR=${CURRENT%%.*}
MINOR=${CURRENT##*.}
NEXT="${MAJOR}.$((MINOR + 1))"
echo "Versión publicada: ${CURRENT} -> nueva: ${NEXT}"

# Compilación de la imagen
docker build -t "${IMAGE}:latest" -t "${IMAGE}:${NEXT}" .

# Login Registry (Docker Hub)
printf '%s' "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Subida de la imagen
docker push "${IMAGE}:latest"
docker push "${IMAGE}:${NEXT}"

# Solo si la subida ha ido bien se guarda la nueva versión
echo "$NEXT" > VERSION
echo "Publicadas ${IMAGE}:latest y ${IMAGE}:${NEXT}"

# lanzamiento local
# docker run --rm  -p 3001:3000 ${IMAGE}
