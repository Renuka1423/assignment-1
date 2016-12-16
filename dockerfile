##  Assignment-1 ##


FROM centos:6.6                                  ##Build centos 6.6 image from docker hub repository.

RUN yum install wget -y                          ##Install wget on the container machine.   
RUN yum install tar -y                           ##Install tar package on container.

#########################################################################################################################################################################                                     Python 2.7.8 setup                                                                                                               #
########################################################################################################################################################################

RUN yum install gcc -y                           ##Install GCC and development tools.

RUN yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel -y 
                                                 ##You also need a few extra libs installed before compiling Python or else you will run into problems later when trying                                                 ##to install various packages:You also need a few extra libs installed before compiling Python or else you will run                                                     ##into problems later when trying to install various packages:

RUN wget https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz -O /usr/src/Python-2.7.8.tgz 
                                                 ##Download Python package.

RUN tar xzf /usr/src/Python-2.7.8.tgz -C /usr/src/
                                                 ##Extract package into /usr/src directory.

RUN /bin/sh /usr/src/Python-2.7.8/configure      ##Execute configure file.

RUN make altinstall                              ##make altinstall is used to prevent replacing the default python binary file /usr/bin/python.


#########################################################################################################################################################################                                    MongoDB server setup                                                                                                              
######################################################################################################################################################################## 
RUN ( echo [mongodb] ; echo "name=MongoDB Repository" ; echo "baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/" ; echo "gpgcheck=0" ; echo "enabled=1" ) >> /etc/yum.repos.d/mongodb.repo              ##Create mongod repo in /etc/yum.repos.d directory.
 
RUN yum install mongo-10gen mongo-10gen-server -y --enablerepo=mongodb 
                                                 ##Install mongoDB using yum.   
CMD mongod start                                 ##start mongodb server.   
RUN chkconfig mongod on                          ##Service will be running after the machine reboot.

#########################################################################################################################################################################                                   Download JDK-1.7.55
########################################################################################################################################################################

RUN cd /opt;wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.tar.gz; pwd
RUN cd /opt;tar xvf jdk-7u55-linux-x64.tar.gz
RUN alternatives --install /usr/bin/java java /opt/jdk1.7.55/bin/java 2

#########################################################################################################################################################################                                  Download Apache Tomcat 7 server
########################################################################################################################################################################

RUN cd /tmp;wget http://apache.mirrors.pair.com/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz
                                               ##Download tomcat7 package.

RUN cd /tmp;tar xvf apache-tomcat-7.0.73.tar.gz 
                                               ##Extract tomcat7 package. 

RUN cd /tmp;mv apache-tomcat-7.0.73 /opt/tomcat7
                                               ##Move packate to /opt directory.

RUN chmod -R 755 /opt/tomcat7                  ##Provide 0755 permission. 

ENV JAVA_HOME /opt/jdk1.7.0_55                 ##Set java home environment variable.  

EXPOSE 8080                                    ##Open port 8080 on container machine.

CMD /opt/tomcat7/bin/catalina.sh run           ##Start tomcat service.

