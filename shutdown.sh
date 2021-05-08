#!/bin/bash

echo "shutting down servers"
docker-compose down
docker rm node_npm_install node_test