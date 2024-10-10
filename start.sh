#!/bin/bash

# Exit immediately if any command fails
set -e

source helpers.sh

echo "Starting PHP + React site on your local."


# Check if the first argument is "-build"
if [ "$1" == "-build" ]; then
  run_npm_install
fi
verify_docker_running

stop_containers_on_port 80
stop_containers_on_port 81
stop_containers_on_port 443
stop_containers_on_port 3306
stop_containers_on_port 8080
stop_process_on_port 80
stop_vite

start_docker_containers
run_npm_start
