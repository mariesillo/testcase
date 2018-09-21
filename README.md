# Testcase Repository

## Statsd Memory Usage Demo

This repository is intended to demo a complete environment using Statsd with Graphite with the help of docker-compose to monitor Memory on several containerized "servers".

### How to use this demo?

I recomend to run this repository on Play-With-Docker in the following link [PWK](https://labs.play-with-docker.com)

##### **Pre-requirements:**

You must have installed [docker engine](https://docs.docker.com/install/) and [docker-compose](https://docs.docker.com/compose/install/), refer the links for installation instructions:

##### Start environment

First clone this repository and go to testcase directory

```
git clone https://github.com/mariesillo/testcase.git
cd testcase
```

Finally run start script to start environment.

```
./start.sh
```

Once the script completed, you can go to Graphite URL i.e. "http://localhost"

Using Play-With-Docker you can click on the newly created link with the port **80**, PWD will redirect you to Graphite Dashboard.

To remove the environment please run bellow commands:

```
docker-compose down
docker rmi testcase_servers:latest   
```

### How to Scale?

Environmet uses docker-compose scale feature, in order to scale to different amount of "server" containers (default 6 containers) please tear down the environment and modify docker-compose.yaml file scale property, i.e. 20 servers:

```
version: '2.3'
services:
  .....
  servers:
    .....
    scale: 20
    .....
```
