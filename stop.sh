#!/bin/bash

# Exit immediately if any command fails
set -e

source helpers.sh

echo "Stopping the application"


stop_containers_on_port 81
stop_containers_on_port 443
stop_containers_on_port 3306
stop_containers_on_port 8080
stop_process_on_port 80
stop_vite

