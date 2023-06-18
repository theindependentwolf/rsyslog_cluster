# RSYSLOG CLUSTER

## Steps to setup rsyslog cluster

#### 1. Create a dockerfile for rsyslog

    Create a docker file that compiles rsyslog from source repository

#### 2. Create rsyslog.conf file

    Create a simple rsyslog conf file that redirects all logs to /var/log/rsyslog.log

#### 3. Create a rsyslog docker image

- Make sure docker is installed and docker daemon is running
- Build Image

  docker build -t rsyslog-image .
- Install dependencies when/if you encounter problems during installation (Modify dockerfile)

#### 3. Check if the image has been generated

    docker images

#### 4. Create a docker compose file for rsyslog and nginx load balancer

    This file creates three services. Two rsyslog instances from the docker image we just created and a load balancer using nginx. Create a nginx config file. The nginx instance is created from the latest nginx image and exposes ports 514 and 80 for log ingestion and load balancing.

The nginx configuration sets up a reverse proxy to balance the load between the rsyslog1 and rsyslog2 services on port 514.

#### 5. Start the services

docker-compose up -d

This command will build the rsyslog services based on the Dockerfile, create the necessary volumes, and start the containers. The `-d` flag runs the containers in the background.

#### 6. Check the containers that are running

docker ps

#### 7. Check for logs if there is any problem

docker compose logs

#### 8. SSH into docker container to debug

docker exec -it `<container_id> sh`


## Test Cluster

To test log ingestion and verify that the logs are being ingested by your rsyslog instances and load balancer, you can follow these steps:

#### 1. Send test log messages

    Use a tool like curl to send some test messages

curl -vX POST -d "This is a sample message from MARS" http://localhost:80

#### 2. Check if the test message has been received

    Log into a docker instance and check the test messages

a. Find the docker container id of the rsyslog instances

docker ps

b. Log into specific instance

docker exec -it `<container_id> sh`

c. cat /var/log/rsyslog.log

d. Alternatively, you can get the messages from the local mounted volume, rsyslog1 and rsyslog2



## Diagnostics

Below are some commands that will help you diagnose issues in your cluster

#### 1. Get the IP address of a container

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container_name_or_id>

#### 2. Curl Command

To send and receive messages

#### 3. To log into a docker instance

docker exec -it `<container_id> sh `
You can get the container ID by doing the `docker ps` command

#### 4. To bring down and bring up the cluster

```
docker compose down
docker compose up -d
```

##### 5. Some docker commands

```
docker rm <container_id> #To remove container
docker stop <container_id> #To start container
docker start <container_id> #To start container
docker rm $(docker ps -a -q) #To remove all docker containers at once

```
