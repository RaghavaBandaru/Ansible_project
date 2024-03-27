#! /bin/bash

# Global Variables
LOG=/tmp/devops.log
G="\e[32m"
R="\e[31m"
N="\e[0m"

# Heading Function
HEADING() {
  echo -e "\n\t\t\e[1;4;33m$1\e[0m\n"
}

# Status check function
STATUS_CHECK() {
  if [ $1 -eq 0 ]; then
    echo -e "$2 -- ${G}SUCCESS${N}"
  else
    echo -e "$2 -- ${R}FAILURE${N}"
    exit 1
  fi
}

hostnamectl set-hostname ansible-controller

# install ansible
yum-config-manager --enable epel
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install epel-release-latest-7.noarch.rpm
yum update -y
yum install python python-devel python-pip openssl ansible git -y

sudo su -
# add the user ansible
sudo useradd devops
# set password : the below command will avoid re entering the password
sudo echo "devops" | passwd --stdin devops
sudo echo "devops" | passwd --stdin ec2-user

# Generate SSH Key for Passwordless configurations
sudo su - devops -c "yes '' | ssh-keygen -N '' -f /home/devops/.ssh/id_rsa > /dev/null"

# modify the sudoers file at /etc/sudoers and add entry
echo 'devops     ALL=(ALL)      NOPASSWD: ALL' | sudo tee -a /etc/sudoers
echo 'ec2-user     ALL=(ALL)      NOPASSWD: ALL' | sudo tee -a /etc/sudoers
# this command is to add an entry to file : echo 'PasswordAuthentication yes' | sudo tee -a /etc/ssh/sshd_config
# the below sed command will find and replace words with spaces "PasswordAuthentication no" to "PasswordAuthentication yes"
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo service sshd restart

# Install Required Softwares
yum install tree wget zip unzip gzip openssh-clients vim net-tools git bind-utils python2-pip jq -y &>>$LOG
git --version &>>$LOG
STATUS_CHECK $? "Successfully Installed Required Softwares\t"

sudo su - devops -c "git config --global user.name 'devops'"
sudo su - devops -c "git config --global user.email 'devops@gmail.com'"
