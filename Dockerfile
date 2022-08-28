# Setting the base image as ubuntu
FROM ubuntu
Maintainer majid-wasabi
# Install prerequisites
RUN apt-get -y update
RUN apt-get -y install curl
RUN apt-get -y install openjdk-11-jdk

# Install tomcat
RUN mkdir /opt/tomcat
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65.tar.gz
Run tar xzvf apache*.tar.gz -C /opt/tomcat --strip-components=1

# Selecting an app for the container to execute
WORKDIR /opt/tomcat/webapps
RUN curl -O -L https://github.com/AKSarav/SampleWebApp/raw/master/dist/SampleWebApp.war
CMD ["/opt/tomcat/bin/catalina.sh", "run"]