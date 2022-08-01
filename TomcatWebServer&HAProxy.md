### [1] Set up Compute Engine Instance

### [2] Set up Compute Engine Instance

> sudo apt update
> sudo apt upgrade
> sudo apt install default-jdk

### [3] Create and Setup Tomcat User: For security purposes we shall create a non root user to run the Tomcat service.

> sudo groupadd tomcat

#### create a new tomcat user and assign it to the home directory /opt/tomcat where we are going to install Tomcat.

> sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

### [4] Install Tomcat: to install the latest binary release of Tomcat for the official Tomcat downloads page, under the binary distributions > below core, then copy the link of the file with extension tar.gz for use in the next step

#### [a] Create the directory for Tomcat installation

> sudo mkdir /opt/tomcat

#### [b] Download Tomcat using the link we've copied

> cd /tmp curl -O <link>
> sudo tar <filedownloaded> -C /opt/tomcat --strip-components=1

### [5] Setup permissions

> cd /opt/tomcat
> sudo chgrp -R tomcat /opt/tomcat
> sudo chmod -R g+r conf
> sudo chmod g+x conf
> sudo chown -R tomcat webapps/ work/ temp/ logs/

### [6] Create Service: To run Tomcat as a service you need to setup this with a systemd service file.

#### [a] Create the directory for Tomcat installation

> sudo update-java-alternatives -l
