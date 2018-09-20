#!/bin/bash

# Vaidate if docker is already installed

echo "Please Make sure docker is already installed"

docker version

if [ $? -eq 0 ]
  then
    echo "Docker installed correctly"
  else
    echo "Install docker"
fi

# Generate SSH key

#ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

ssh-keygen -t rsa -b 4096 -f /tmp/sshkey -q -N ""
sh-keygen -y -f /tmp/sshkey > /tmp/sshkey.pub


# Start docker services

echo "Starting Graphite and Statsd conatiner and Ubuntu Servers"

docker-compose up -d

echo "Validate deployments"

docker-compose ps

# Check for docker internal IPs and send to a file

echo "Adding IPs from docker containers to a file"

docker ps -q | xargs -n 1 docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' > servers.txt

#####docker ps -q | xargs -n 1 docker inspect --format '{{ .NetworkSettings.IPAddress }}' | sed 's/ \// /'

# Get Graphite IP to pass into Mem Script

GRAPHITE=`docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps | grep "graphite" | awk '{ print $1 }')`

# Define Meme 

CMD=`while true; do echo -n "$HOSTNAME:`free | grep Mem | awk '{print $3/$2 * 100.0}'`|c" | nc -w 1 -u $GRAPHITE 8125; done`

# Execute memory 
for ip in $(cat servers.txt)
do
ssh root@${ip} "$CMD"
done  

# Complete Script

echo "Check on Graphite URL for metrics"