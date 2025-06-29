# Step 1: Creating GitHub Repository & Initializing Local Directory

## Commands Used

```bash
git init

git add Flow.md

git branch -M main

git commit -m "test"

git remote add origin https://github.com/Siarhii/theLonelyBag_Assignment.git

git push -u origin main
```

# Step 2: Creating a basic node.js application to containarize

## Commands Used

```bash
npm init -y

npm i express

node index.js
```

## commit the changes after making sure everyhing is working fine and push the changes on github

# Step 3: Containerize and run the app (keeping in mind the mountpoint /app/data)

3.1 creating a docker file and dockerignore file
3.2 building the docker image using docker build -t thelonelybag_assignment:1.0 .
3.3 start the app using docker run -d -p 8080:3000 --name thelonelybag-assignment-t1 --mount type=bind,source="C:\\Users\\sarth\\Desktop\\theLonelyBag\\data",target=/app/data thelonelybag-assignment:2.0

# Step 4:deploying on ec2

# Make the file readable only by the current user

icacls .\thelonelybag_assignment_sshkeypair.pem /inheritance:r
icacls .\thelonelybag_assignment_sshkeypair.pem /grant:r "$($env:USERNAME):(R)"

# ssh into the ec2

ssh -i .\thelonelybag_assignment_sshkeypair.pem ubuntu@54.210.213.67

# basic refresh

apt update && upgrade

# changing port for basic botnet detterence

sudo nano /etc/ssh/sshd_config
sudo systemctl restart ssh

# making sure the only my ipv6 is allowed for ssh (my isp has cgnat ipv4 that means my ipv4 is shared so even if i only allow my ipv4 for ssh access it wont be secured, so instead i will mkkae it so that ssh will only be allowed via ipv6 and use my own global ipv6 for ssh and turn of ipv4 ssh access)

ssh -i .\thelonelybag_assignment_sshkeypair.pem -p 1234 ubuntu@2600:1f18:2f7a:5100:b86a:5f4e:36eb:30a7

# Step 5: installing and running docker inside the ec2 instance

5.1 following all the standard steps to install docker including gfg key verification
Install Docker on EC2
Once connected via SSH on your new IPv6 port:

Update package lists (important to run this first and check for errors!):

Bash

sudo apt update
Install necessary packages for Docker:

Bash

sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
Add Docker's GPG key:

Bash

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
Add Docker's repository to Apt sources:

Bash

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
Update package lists again to include Docker's repository (CRITICAL: Watch for errors here!):

Bash

sudo apt update
If this command shows errors related to the Docker repository (e.g., "failed to fetch" or "couldn't resolve host"), this is the source of your installation problem.
Common issues here include:

Incorrect repository URL or GPG key.

Network connectivity issues from your EC2 instance to Docker's download servers.

Install Docker Engine:

Bash

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
Add your ubuntu user to the docker group (so you don't need sudo for every Docker command):

Bash

sudo usermod -aG docker ubuntu
Apply the new group membership (important!):
For the group change to take effect immediately without logging out and back in, you can run:

Bash

newgrp docker
(Note: This newgrp command only applies to your current shell session. For future sessions, you'd need to log out and back in, or use sudo docker.)

Verify Docker installation:

Bash

docker run hello-world
You should see a message indicating Docker is installed and working.

5.2 pull/run docker image i have uploaded from my local machine (docker push sarthak69/thelonelybag-assignment:2.0) using docker pull sarthak69/thelonelybag-assignment:2.0 in ec2 and then docker run with portmapping, and bind mounting docker run -d -p 8080:3000 --name thelonelybag-assignment-ec2 --mount type=bind,source=/home/ubuntu/thelonelybag_appdata,target=/app/data sarthak69/thelonelybag-assignment:2.0

# step 6 : bonus task IAM access

all the stuff in aws console for iam
create s3
create iam role
assign iam role to ec2

## check s3 access from ec2

1.  Install unzip (often needed for the bundled installer)
    sudo apt update
    sudo apt install -y unzip

2.  Download the AWS CLI v2 bundled installer
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

3.  Unzip the installer
    unzip awscliv2.zip

4.  Run the install script
    sudo ./aws/install

        5. Verify the installation

    aws --version

check if s3 is accessible from ec2 using aws s3 ls

# step 7 : launching a new ec2 using cloud-init

create cloud-init.sh
create a new ec2 (we alsready have security group , vpc setup previously, just need to selet it from dropdown, under advance we upload out cloud-init.sh in userdata input ) and finally launch it

# step 8 : creating a deploy.sh
