#!/bin/bash
. ./.env

docker run -v $JENKINS_WORKSPACE/$JOB_NAME/test:/home/test --name node_test --network $NETWORK_NAME -w /home/test node:latest sh -c 'npm install && npm run test-jenkins'

# docker run -v $JENKINS_WORKSPACE/$JOB_NAME/test:/home/test --name node_npm_install --network $NETWORK_NAME -w /home/test node:latest npm run test-jenkins