#!/bin/bash

echo "shutting down servers"
docker-compose down
docker rm node_test