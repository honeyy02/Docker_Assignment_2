FROM openjdk:11
WORKDIR /app
COPY /var/lib/docker/volumes/my_volume/_data .
