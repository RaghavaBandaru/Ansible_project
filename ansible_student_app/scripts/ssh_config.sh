#!/bin/bash
sleep 60
filename='private_ips.txt'
for server in `cat $filename`;
do
    ssh-keyscan -H "$server" >> ~/.ssh/known_hosts
    sshpass -p "devops" ssh-copy-id -f -i ~/.ssh/id_rsa.pub devops@"${server}"
done
