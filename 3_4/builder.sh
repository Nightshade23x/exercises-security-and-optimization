
#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
    echo "Usage: ./builder.sh <github-repo> <docker-image>"
    exit 1
fi

: "${DOCKER_USER:?Docker Hub username required}"
: "${DOCKER_PWD:?Docker Hub token required}"

GITHUB_REPO="$1"
DOCKER_IMAGE="$2"

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

printf '%s' "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin

git clone "https://github.com/$GITHUB_REPO.git" "$TEMP_DIR/repo"

docker build -t "$DOCKER_IMAGE:latest" "$TEMP_DIR/repo"

docker push "$DOCKER_IMAGE:latest"
