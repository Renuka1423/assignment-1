#################################################################################
#                                                                               #
# This is readonly file to help you to execute assignment-1                     #
# Prerequisites - centos 6.6 vm as a host machine with docker setup             #
# Author - gaikwad.renuka1423@gmail.com                                         #
#                                                                               #
#################################################################################

Directory          - assignment-1
dockerfile content - Python-2.7.8
                     apache-tomcat-7.0.73.tar.gz
                     mongodb-2.6.12

Step 1 : clone/download the directory "assignment-1" on your host machine

------------------------------------------------------------------------------------------------------------------------

Step 2: Open port 7080 on the host machine using the following command.
sudo lokkit -p 7080:tcp

-------------------------------------------------------------------------------------------------------------------------

Step 3: Docker setup should be present on the host machine. Follow the given commands to execute the dockerfile.

<>$cd assignment-1                                        ##Go to assignment-1 directory. 
<>$sudo docker build .                                    ##This command will execute the dockerfile and build docker image out of it.
<>$sudo docker images                                     ##Command to check the latest build docker image.

Check the output shown below.
#############################################################################################################
compose@amp docker]$ sudo docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
<none>              <none>              2cf4f6a77654        29 seconds ago      1.505 GB
centos              6.6                 d0d663863c34        3 months ago        202.6 MB
############################################################################################################

<>$sudo docker run -d -p 7080:8080 <<docker imageid>>     ## This will run the container in deamon mode and will create outbound mapping of 
                                                           port 8080 to 7080 on host machine. provide latest build docker image id of our dockerfile.

you should see output like below shown.
###########################################################################################################
[compose@amp docker]$ sudo docker run -d -p 7080:8080 2cf4f6a77654
8dc9b6bb913ca3eb655a5e0f61033a439daf7146c549b82d10803a7b7b0acbd8
##########################################################################################################

<>$sudo docker ps -a                                      ## Do check your latest container created by the image id.

you should see the output like below shown.
#########################################################################################################
[compose@amp docker]$ sudo docker ps -a
CONTAINER ID        IMAGE               COMMAND                CREATED              STATUS              PORTS                    NAMES
8dc9b6bb913c        2cf4f6a77654        "/bin/sh -c '/opt/to   About a minute ago   Up About a minute   0.0.0.0:7080->8080/tcp   silly_mayer
########################################################################################################


<>$sudo docker exec -ti <<container-id>> /bin/bash        ## Login into container machine and explore the Python,mongodb,tomcat7 installed setup.


Now the bash prompt for the container will be there and you can execute any commands as same as your host machine.

-----------------------------------------------------------------------------------------------------------------------------
<EOF>

