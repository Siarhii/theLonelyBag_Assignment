#!/bin/bash

sudo apt update -y

sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker ubuntu

git clone https://github.com/Siarhii/theLonelyBag_Assignment.git /home/ubuntu/theLonelyBag

# Navigate to your app directory
cd /home/ubuntu/theLonelyBag

# pull the Docker Image
docker pull sarthak69/thelonelybag-assignment:2.0 

# Create the Host Data Directory for Bind Mount
mkdir -p /home/ubuntu/appdata

# Run the Docker Container with the Bind Mount
docker run -d -p 8080:3000 --name thelonelybag-assignment-ec2-automated --mount type=bind,source=/home/ubuntu/appdata,target=/app/data sarthak69/thelonelybag-assignment:2.0
