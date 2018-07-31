# Jenkins Docker

Use to create a custom Jenkins master image with Docker. 

* Adds .NET CORE 2.0 
* Pre-installs a host of Jenkins Plugins
* Contains the base for 2 Jenkins Pipeline alternatives



# Setup Info
* Builds the Jenkins Container off our Dockerfile, which add .NET core
* Creates/Maps the Docker Volumes "jenkins-data" and maps to the jenkins home directory.
  * https://docs.docker.com/storage/bind-mounts/
*  Runs the container as a daemon with the name "jenkins"

docker build -t jenkins-docker-master .

docker run --rm -d -p 49001:8080 -v jenkins-data:/var/jenkins_home --name jenkins-master jenkins-docker-master

Upon installation Jenkins will ask for an initial setup password which can be located in the logs:
docker logs jenkins

# View Installed Plugins
Visit the following URL: <localhost:port>/scripts

**Run the following**
```
Jenkins.instance.pluginManager.plugins.each{
  plugin ->

    println ("${plugin.getShortName()}")
}
```

# Docker Commands
### **Using a Dockerfile**

docker build -t test_appplicaiton_name .

docker run -e NAME=app test_application_name

###  **List all docker containers**
docker ps -a

###  **List running docker containers**
docker -ps 

###  **Docker Publish Port**

docker run -d -p 9090:8080 tomcat
docker run -d --name couchdb -p 5986:5986 couchdb

### **Attach a docker volume**
docker run -i -t -v ~/docker_ubuntu:/host_directory ubuntu:16.04 /bin/bash

### **List all docker images**
docker images

### **Remove all docker containers**
docker rm $(docker ps --no-trunc -aq)

### **Remove a single docker container**
docker rm <container>

### **Check a docker daemons log**
docker logs <container>

### **Stop a docker container**
docker stop

### **docker tagging**
<registry_addres>/<image_name>:<version>

### **Name a docker container** 
docker run -d --name <name> tomcat

### **Automatically attach all docker ports to available host ports**
docker run -P

### **Enter docker shell (jenkins):**
docker run -p 8080:8080 -p 50000:50000 -it jenkins bin/bash

### List Docker Volumes
docker volume ls
