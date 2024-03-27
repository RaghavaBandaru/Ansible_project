## Step-1: Create Workspace

#### In the windows Open the Git Bash and switch to the directory where scripts can be executed

      Ex: \d\workspace\

## Step-2: Clone the Repo

      $ git clone https://gitlab.com/rns-devops/terraform.git

## Step-3: Open the project in atom

      $ cd terraform/7.ansible_student_app && atom .

## Step-4: in GitBash run the terraform commands

      $ terraform init

      $ terraform fmt

      $ terraform validate

      $ Terraform apply --auto-approve

## Step-5: Login to the Ansible Controller using Mobaxterm

      - Public IP Address of Controller

      - UserName: devops

      - Password: devops

## Step-6: Password less configuration between controller to the Target Nodes

      1. Collect the Private IP addresses of the Target Nodes

          Ex: 172.20.10.85 and 172.20.10.132

      2. Check the SSH communication with Password

          $ ssh devops@172.20.10.85

              L> confirm 'yes' and enter password 'devops'

          $ ssh devops@172.20.10.132

              L> confirm 'yes' and enter password 'devops'

      3. Copy the Public Key to the Target Nodes

          $ ssh-copy-id devops@172.20.10.85

              L> Enter password 'devops'

          $ ssh-copy-id devops@172.20.10.132

              L> Enter password 'devops'

      4. Finally re verify the password less authentication

          $ ssh devops@172.20.10.85

          $ ssh devops@172.20.10.132


### Student Application Deployment:

#### MariaDB:
    - Install DB
    - Start/Stop
    - Load App DB Schema (DB Create and Table Create)
      - mysql -uroot < dbscript/student.sql

#### Tomcat:
    - Install
      - install java
      - Download tar file
      - extract it
    - Register as a service
    - Start/Stop as service
    - Configuration of Tomcat:
        - Tomcat Users
        - to allow remote access of manager app (context.xml)
        - Load Driver mariadb (.jar)
        - Connection: URL: localhost:3306/studentapp
            - DB Host: localhost:3306/studentapp
            - DB Port: 3306
            - DB Name: studentapp
            - DB UN: student
            - DB PWD: student1
      - Maven Build
        - Build student app (.war)
      - Deploy the Application

#### Nginx Web Server:
      - Install Nginx
      - Start/Stop server
      - Configure Nginx Server as Proxy
      - Delete default Application
      - Deployment of static App
          - /usr/share/nginx/html/*
