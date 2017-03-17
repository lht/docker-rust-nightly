#!/bin/bash

SITE="https://static.rust-lang.org/dist"

if [ -z "$DATE" ]; then
  DATE=`date +%Y-%m-%d`
fi

TAG="${DATE}"

LINK="${SITE}/${DATE}/rust-nightly-x86_64-unknown-linux-gnu.tar.gz"
echo $LINK

# test if there is a nightly build
if `curl --fail -I ${LINK} >/dev/null 2>&1`; then
    docker build --build-arg BUILD_DATE=${DATE} -t htli/rust-nightly:${TAG} .
    docker images | grep rust-nightly
else
    echo "No nightly build on ${DATE}"
fi
