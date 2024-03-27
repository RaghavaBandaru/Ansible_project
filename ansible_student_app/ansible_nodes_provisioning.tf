# Create hosts file with target nodes private Ips
resource "local_file" "inventory" {
  filename = "./files/hosts"
  content  = "[webserver]\nweb ansible_host=${aws_instance.Ansible_Web_Server.private_ip}\n[appserver]\napp ansible_host=${aws_instance.Ansible_App_Server.private_ip}\n[centos]\nweb\napp"
}

# collect private ips of the target nodes to txt file which should be used for ssh configuration
resource "local_file" "private_ips" {
  depends_on = [
    null_resource.wait_for_instance
  ]

  filename = "./scripts/private_ips.txt"
  content  = "${aws_instance.Ansible_Web_Server.private_ip}\n${aws_instance.Ansible_App_Server.private_ip}\n"
}

# Copy the Roles and configuration files to the Ansible Controller.
resource "null_resource" "wait_for_instance" {
  depends_on = [
    aws_instance.AnsibleController,
    aws_instance.Ansible_Web_Server,
    aws_instance.Ansible_App_Server
  ]

  connection {
    type     = "ssh"
    host     = aws_instance.AnsibleController.public_ip
    user     = "devops"
    password = "devops"
  }

  provisioner "file" {
    source      = "files/"
    destination = "/home/devops/"
  }
}

resource "null_resource" "running_playbooks" {
  depends_on = [
    local_file.private_ips
  ]

  connection {
    type     = "ssh"
    host     = aws_instance.AnsibleController.public_ip
    user     = "devops"
    password = "devops"
  }

  provisioner "file" {
    source      = "scripts/"
    destination = "/home/devops/"
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/devops/",
      "chmod +x ssh_config.sh",
      "sed -i -e 's/\r$//' ssh_config.sh",
      "~/ssh_config.sh",
      "ansible all -m ping",
      "ansible-playbook studentapp-webapp.yml"
    ]
  }
}
