#!/bin/bash
. ./.env

docker run -v $FILE_PATH/$JOB_NAME/test:/home/test --name node_npm_install -w /home/test node:latest npm install

docker run -v $FILE_PATH/$JOB_NAME/test:/home/test --name node_test node:latest node /home/test/run-test.js