#!/bin/bash

SITE="https://static.rust-lang.org/dist"

if [ -z "$DATE" ]; then
  DATE=`date +%Y-%m-%d`
fi

LINK="${SITE}/${DATE}/rust-nightly-x86_64-unknown-linux-gnu.tar.gz"
echo $LINK

# test if there is a nightly build
if `curl --fail -I ${LINK} >/dev/null 2>&1`; then
    docker build --build-arg BUILD_DATE=${DATE} -t htli/rust-nightly:${DATE} .
    docker images | grep rust-nightly

    if [ "$TRAVIS_BRANCH" == "master" ]; then
        docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
        docker push "htli/rust-nightly:${DATE}";
        docker tag "htli/rust-nightly:${DATE}" "htli/rust-nightly:latest";
        docker push "htli/rust-nightly:latest";
    fi

else
    echo "No nightly build on ${DATE}"
fi
