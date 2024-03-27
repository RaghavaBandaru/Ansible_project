#! /bin/bash

# script to install maven
#
sudo chown -R devops:devops /opt/

# Deploy the Application
sudo rm -rf /tmp/student-app
sudo rm -rf /opt/student-app
cd /tmp/ && git clone https://gitlab.com/raghavabandaru854/student-app.git

# Clone App and Deploy it to Tomcat SErver
cd /opt/
cp -R /tmp/student-app /opt/
#cd /opt/ && git clone https://gitlab.com/rns-app/student-app.git
#source /home/ec2-user/.bashrc
cd /opt/student-app && mvn clean package -DskipTests
cp /opt/student-app/target/studentapp*.war /opt/apache-tomcat-9.0.85/webapps/student.war
