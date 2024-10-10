#!/bin/bash

run_npm_install() {
  echo "Running npm install..."

  if npm install; then
    echo "Dependencies installed successfully."
  else
    echo "Failed to install dependencies."
    exit 1
  fi
}

verify_docker_running() {

    echo -n "Verifying if Docker is running..."

    # Check if Docker process is running
    if pgrep -i "docker" 2>&1 >/dev/null; then
        # Ensure Docker is responsive
        if docker stats --no-stream >/dev/null 2>&1; then
            echo "Docker is up and operational."
        else
            echo "Docker process found, but it's unresponsive."
            echo -e "\tPlease ensure Docker is fully running and try again."
            exit 1
        fi
    else
        echo "Docker is not running."
        echo -e "\tPlease start Docker first."
        exit 1
    fi

}

stop_containers_on_port() {
  local port="$1"

  echo "Checking for containers running on port $port..."

  # Find container IDs using the specified port
  container_ids=$(docker ps --filter "publish=$port" --format "{{.ID}}")

  if [ -z "$container_ids" ]; then
    echo "No containers found running on port $port."
  else
    echo "Stopping containers on port $port..."
    for container in $container_ids; do
      docker stop "$container" && echo "Stopped container: $container"
    done
  fi
}

stop_process_on_port() {
  local port="$1"

  echo "Checking for process running on port $port..."

  # Check if lsof is available
  if ! command -v lsof &> /dev/null; then
      echo "lsof command not found, please install it."
      return 1
  fi

  # Find the process ID (PID) using lsof
  process_pid=$(lsof -t -i:"$port" 2>/dev/null) || process_pid=''

  # Debugging output to verify PID retrieval
  echo "Process PID: $process_pid"

  if [ -z "$process_pid" ]; then
    echo "No process is running on port $port."
  else
    echo "Stopping process running on port $port (PID: $process_pid)..."
    
    # Stop the process
    if kill "$process_pid"; then
      echo "Process (PID: $process_pid) has been stopped."
    else
      echo "Failed to stop process (PID: $process_pid). You may need to run this script with elevated privileges (e.g., using sudo)."
    fi
  fi
}

stop_vite() {
  echo "Stopping all Vite server instances..."

  # Get the process IDs (PIDs) of all Vite processes
  vite_pids=$(ps -ax | grep '[v]ite' | awk '{print $1}')

  if [ -z "$vite_pids" ]; then
    echo "No Vite server is currently running."
  else
    echo "Stopping Vite servers (PIDs: $vite_pids)..."
    sudo kill -9 $vite_pids && echo "All Vite servers have been stopped."
  fi
}


start_docker_containers() {
  echo "Starting Docker containers..."

  # Navigate to the Docker directory
  if ! cd docker; then
    echo "Failed to change directory to 'docker'."
    exit 1
  fi

  # Try to start Docker containers
  if ! docker-compose up -d; then
    echo "Failed to start Docker containers."
    cd - > /dev/null || exit 1  # Go back to the previous directory
    exit 1
  fi

  cd - > /dev/null || exit 1
  echo "Docker containers started successfully."
}

run_npm_start() {
  echo "Starting the application with 'npm start' using sudo."
  echo "Warning: This script will prompt for your user account password (the same one you use to log in to your computer) to run 'npm start' with sudo."
  echo "Please ensure your user account has permission to use sudo."

  # Run npm start with sudo
  if sudo npm start; then
    echo "Application started successfully."
  else
    echo "Failed to start the application."
    exit 1
  fi
}
