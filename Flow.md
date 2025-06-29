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
