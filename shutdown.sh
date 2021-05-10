#!/bin/bash

echo "shutting down servers"
# docker-compose down # this fails since there is no .env file yet

# the below does not throw error  if container does not exists
docker kill website mysql || true && docker rm website mysql || true
docker kill node_test || true && docker rm node_test || true