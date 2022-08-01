### [1] Set up Compute Engine Instance

### [2] Set up Compute Engine Instance

> sudo apt update
> sudo apt upgrade
> sudo apt install default-jdk

### [3] Create and Setup Tomcat User: For security purposes we shall create a non root user to run the Tomcat service.

> sudo groupadd tomcat

#### Create a new tomcat user and assign it to the home directory /opt/tomcat where we are going to install Tomcat.

##### -s, --shell SHELL > The name of the user's login shell.

##### -g, --gid GROUP > The group name or number of the user's initial login group.

##### -d, --home HOME_DIR > The new user will be created using HOME_DIR as the value for the user's login directory.

> sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

### [4] Install Tomcat: to install the latest binary release of Tomcat for the official Tomcat downloads page "https://tomcat.apache.org/download-10.cgi", under the "Binary Distributions" section > below core, then copy the link of the file with extension tar.gz for use in the next step

#### [a] Create the directory for Tomcat installation

> sudo mkdir /opt/tomcat

#### [b] Download Tomcat using the link we've copied

##### Go to the tmp directory:

> cd /tmp

##### Download the tar file to the tmp directory:

> curl -O <link>

##### install tomcat using the tar file to /opt/tomcat:

###### -C, --directory=DIR > change to directory DIR

###### --strip-components=NUMBER > strip NUMBER leading components from file names on extraction

> sudo tar xzvf <filedownloaded> -C /opt/tomcat --strip-components=1

### [5] Setup user permissions:

> cd /opt/tomcat
> sudo chgrp -R tomcat /opt/tomcat
> sudo chmod -R g+r conf
> sudo chmod g+x conf
> sudo chown -R tomcat webapps/ work/ temp/ logs/

###### chgrp command in Linux is used to change the group's ownership of a file or directory

###### chmod used to change permissions

### [6] Create Service: To run Tomcat as a service you need to setup this with a systemd service file.

#### [a] Create the directory for Tomcat installation:

> sudo update-java-alternatives -l

#### [b] Create a new file for Tomcat inside /etc/systemd/system directory:

> sudo nano /etc/systemd/system/tomcat.service

#### [C] Add the following:

###### Make sure to modify the JAVA_HOME with the path of your Java installation.

######

[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target

######

#### [d] Reload the systemd daemon:

> sudo systemctl daemon-reload

#### [f] Start the Tomcat Server:

> sudo systemctl start tomcat

#### [g] Enable Tomcat to startup on system boot:

> sudo systemctl enable tomcat

### [7] Configure Tomcat

#### To use the manager web app you need to login to the server

#### [a] setup username and password

> sudo nano /opt/tomcat/conf/tomcat-users.xml
> <tomcat-users . . .>

    <user username="admin" password="password" roles="manager-gui,admin-gui"/>

</tomcat-users>

#### [b] By default Tomcat restricts access to Manager and Host manager.

#### So, to allow connections you need to remove the IP restrictions from the corresponding context.xml files:

###### For the Manager app the file that needs be updated is:

> sudo nano /opt/tomcat/webapps/manager/META-INF/context.xml

###### For the Host Manager app the file that needs be updated is:

> sudo nano /opt/tomcat/webapps/host-manager/META-INF/context.xml

###### Comment out the value section to remove the IP restriction as shown below:

> <Context antiResourceLocking="false" privileged="true" >

  <!--<Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />-->
</Context>

### [7] Configure firewall:

##### By default Tomcat runs on port 8080, So you need to open port 8080 to allow connections:

- In your Google Cloud Console go to VPC Network, Firewall rules and click Create Firewall rules.
- In Name enter tomcat
- In Targets select All instances in the network
- In Source filter select IP ranges
- In Source IP ranges enter 0.0.0.0/0
- In Protocols and ports check TCP and enter 8080.
- Click Create
- or in cmd:
> gcloud compute --project= <project-id> firewall-rules create tomcat --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8080 --source-ranges=0.0.0.0/0

### Step [8] Access Tomcat Interface

> http://IP_ADDRESS:8080
