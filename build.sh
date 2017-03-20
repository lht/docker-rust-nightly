#!/bin/bash

set -e

SITE="https://static.rust-lang.org/dist"

if [ -z "$DATE" ]; then
  DATE=`date +%Y-%m-%d`
fi

IMAGE="htli/rust-nightly"
IMAGE_DATE="${IMAGE}:${DATE}"
IMAGE_DATE_NODOCS="${IMAGE}:${DATE}-nodocs"

LINK="${SITE}/${DATE}/rust-nightly-x86_64-unknown-linux-gnu.tar.gz"
DOC_LINK="${SITE}/${DATE}/rust-docs-nightly-x86_64-unknown-linux-gnu.tar.gz"

# test if there is a nightly build
if `curl --fail -I ${LINK} >/dev/null 2>&1`; then
    docker build --build-arg BUILD_DATE="${DATE}" -t "${IMAGE_DATE_NODOCS}" .
    docker tag "${IMAGE_DATE_NODOCS}" "${IMAGE}:latest-nodocs";

    docker images | grep rust-nightly

    sed s/%DATE%/${DATE}/g Dockerfile.docs.in > Dockerfile.docs
    docker build -t ${IMAGE}:${DATE} -f Dockerfile.docs .
    docker tag ${IMAGE}:${DATE} ${IMAGE}:latest

    if [ "$TRAVIS_BRANCH" == "master" ]; then
        docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
        docker push "${IMAGE}:${DATE}";
        docker push "${IMAGE}:${DATE}-nodocs";
        docker push "${IMAGE}:latest";
        docker push "${IMAGE}:latest-nodocs";
    fi

else
    echo "No nightly build on ${DATE}"
fi
