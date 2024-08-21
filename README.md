# Docker_Assignment_2
Create docker image which will use jdk11 as base and copy jar created in assignment 1
Here are the steps to complete Docker Assignment 2:
1. **Copy the JAR file from volume to local directory:**
    - Create a local directory for the JAR file: `mkdir jar-file`
    - Get the mount point of the volume: `docker volume inspect my-volume`
    - Copy the volume contents to the jar-file directory: `sudo cp -r /var/lib/docker/volumes/my_volume/_data/* ./jar-file`
    - Verify that the jar-file directory contains the JAR file
2. **Build and Run Dockerfile to copy the JAR file to the container:**
3. **Build the Docker image:**
`docker build -t honeyy02/assignment2 .`
4. **Run the Docker image:**
`docker run -d --rm honeyy02/assignment2:latest`
