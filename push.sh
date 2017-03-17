#!/bin/bash

if [ "$TRAVIS_BRANCH" == "master" ]; then
  docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
  docker push "htli/rust-nightly:${DATE}";
fi
