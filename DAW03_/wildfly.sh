#!/bin/sh
# https://computingforgeeks.com/install-wildfly-application-server-on-ubuntu-debian/
# https://www.youtube.com/watch?v=I_aBKxwPhWw&t=2931s
#Install OpenJDK
#Install Java SE Development Kit
sudo apt update
sudo apt -y install default-jdk
#Comprobar
$ java --version
# si no tenemos el curl
sudo apt install curl wget

#descargamos el tar.gz

#Once the file is downloaded, extract it.


#Move resulting folder to /opt/wildfly.
#mkdir /opt/wildfly
#en /opt/ descomprimir el wildfly 
sudo mv wildfly-${WILDFLY_RELEASE} /opt/
tar xvf wildfly-${WILDFLY_RELEASE}.tar.gz
sudo mv wildfly-${WILDFLY_RELEASE} wildfly

#Añadimos el grupo
sudo groupadd --system wildfly
sudo useradd -s /sbin/nologin --system -d /opt/wildfly  -g wildfly wildfly

#Create WildFly configurations directory.

sudo mkdir /etc/wildfly

#copy WildFly systemd service, configuration file and start scripts templates from the /opt/wildfly/docs/contrib/scripts/systemd/ directory.

sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin/
sudo chmod +x /opt/wildfly/bin/launch.sh

#Set /opt/wildfly permissions.
sudo chown -R wildfly:wildfly /opt/wildfly

#Reload systemd service.
sudo systemctl daemon-reload

#Start and enable WildFly service:
sudo systemctl start wildfly
sudo systemctl enable wildfly

#Confirm WildFly Application Server status.
sudo systemctl status wildfly

sudo netstat -putan | grep 8080

#Step 4: Add WildFly Users
#By default WildFly 16 is now distributed with security enabled for the management interfaces. We need to create a user who can access WildFly administration console or remotely use the CLI. A script is provided for managing users.

#Run it by executing the command:

sudo /opt/wildfly/bin/add-user.sh
# a
# wildflyadmin
# abc123.
# yes
# enter (sin grupos)
# yes
# yes

#Accessing WildFly Admin Console
#To be able to run WildFly scripts from you current shell session, add /opt/wildfly/bin/ to your $PATH.
echo $PATH
# hay que ejecutarlo como usuario normal
cat >> ~/.bashrc <<EOF
export WildFly_BIN="/opt/wildfly/bin/"
export PATH=\$PATH:\$WildFly_BIN                                                                                                                    
EOF

#Source the bashrc file.

source ~/.bashrc
echo $PATH

#Now test by connecting to WildFly Admin Console from CLI with jboss-cli.sh command.

#$
jboss-cli.sh --connect
version
exit

# By default, the console is accessible on localhost IP on port 9990.
# sudo systemctl restart wildfly
# ip:9090
##Probar el funcionamiento
sudo apt install maven

# Vamos a ip:8080 (wildfly) quikstart elegimos la rama de nuestra version y descargamos la carpeta 
unzip nombre.zip
cd carpetaHolaMundo
mvn package wildfly:deploy
wildflyadmin
abc123.
#en deplyments en localhost9990
#para probar
localhost:8080/helloworld
