#!/bin/bash

# deploy.sh - Script to deploy the Node.js Docker application by pulling from Docker Hub.
# This script assumes Docker is already installed and the user is in the docker group.

set -e 

echo "Starting Node.js app deployment (pulling from Docker Hub)..."

# 1. Define the application directory (where the repo is cloned)
# Based on your cloud-init, the repo is cloned directly into /home/ubuntu/theLonelyBag_Assignment
APP_DIR="/home/ubuntu/theLonelyBag_Assignment"
if [ ! -d "$APP_DIR" ]; then
  echo "Error: Application directory not found at $APP_DIR. Please ensure the repo is cloned correctly."
  exit 1
fi
cd "$APP_DIR"

echo "Pulling latest changes from GitHub..."
# 2. Pull the latest changes from the GitHub repository
# This ensures the deploy.sh script itself is up-to-date, and any other config files
git pull

echo "Pulling Docker image sarthak69/thelonelybag-assignment:2.0 from Docker Hub..."
# 3. Pull the Docker Image
docker pull sarthak69/thelonelybag-assignment:2.0

echo "Creating host data directory for persistence..."
# 4. Create the Host Data Directory for Bind Mount
PERSISTENT_DATA_DIR="/home/ubuntu/appdata"
mkdir -p "$PERSISTENT_DATA_DIR"

echo "Stopping any existing container named 'thelonelybag-assignment-ec2'..."
# 5. Stop and remove any existing container
docker stop thelonelybag-assignment-ec2 &> /dev/null || true 
docker rm thelonelybag-assignment-ec2 &> /dev/null || true 

echo "Running the Docker container..."
# 6. Run the Docker Container with the Bind Mount
docker run -d -p 8080:3000 \
  --name thelonelybag-assignment-ec2 \
  --mount type=bind,source="$PERSISTENT_DATA_DIR",target=/app/data \
  sarthak69/thelonelybag-assignment:2.0 

echo "Verifying container status..."
# 7. Verify the container is running
docker ps | grep thelonelybag-assignment-ec2

if [ $? -eq 0 ]; then
  echo "Deployment successful! App should be running on port 8080."
else
  echo "Deployment failed! Check docker logs thelonelybag-assignment-ec2 for errors."
fi