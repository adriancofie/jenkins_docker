# Jenkins Docker

Use to create a custom Jenkins master image with Docker. 

* Adds .NET CORE 2.x to base Jenkins image
* Pre-installs a host of Jenkins Plugins
* The root Jenkinsfile was tested while building the ASP.NET app located: https://github.com/adriancofie/aspdotnet_app
  That repository contains an application which defines its own Dockerfile, which is used to setup a .NET context from which to run.
*  An alternative Jenkinsfile is located in the Otherjenkinsfile directory. It instead builds a .NET application within the context of this containers .NET installation. (🛑 ** THIS commited version has not been tested!!**)



# Setup Info

## Description 
* Builds the Jenkins Container off our Dockerfile, which add .NET core
* Creates/Maps the Docker Volumes "jenkins-data" and maps to the jenkins home directory.
  * https://docs.docker.com/storage/bind-mounts/
*  Runs the container as a daemon with the name "jenkins-master"
* Jenkins will be made available at localhost:49001

* NOTE: Docker-in-Docker is not recommended therefore this binds the host Docker to the container.
  * Due to MAC user-group oddities, using ther -u flag to explicitly use root as the default user
* NOTE:  Ideally docker RUN should use the -P flag in combination with the Dockerfile EXPOSE command in order to auto-bind the container ports to the host. 

1)
```
docker build -t jenkins-docker-master .
```


2) 
```
docker run -u root --rm -d -p 49001:8080  -v new-jenkins-data:/var/jenkins_home   -v /var/run/docker.sock:/var/run/docker.sock --name jenkins-master jenkins-docker-master
```


3) Proceed to setup a Pipline project.  On the following screen in the "Pipeline"  section under the Definition drop down select "Pipeline script from SCM". 

4) Under SCM: Paste the git uri of therepo, in this instance : https://github.com/adriancofie/aspdotnet_app.git


5) Click save.  You're now ready to run a build. Once run you should be able to visit the application from your host machine at localhost:9090.  To verify port mappings run "docker ps" 



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

# View Installed Plugins

Visit the following URL: <localhost:port>/scripts

Run the following

```
Jenkins.instance.pluginManager.plugins.each{
  plugin ->

    println ("${plugin.getShortName()}")
}
```

# MISC
Upon installation Jenkins may ask for an initial setup password which can be located in the logs:
docker logs jenkins
