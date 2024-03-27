variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "ports" {
  type    = list(number)
  default = [22, 80, 8080, 3306]
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

output "Ansible_Controller_Public_IP" {
  value = aws_instance.AnsibleController.public_ip
}

output "Ansible_WebServer_Private_IP" {
  value = aws_instance.Ansible_Web_Server.private_ip
}

output "Ansible_AppServer_Private_IP" {
  value = aws_instance.Ansible_App_Server.private_ip
}

output "Ansible_Webserver_Public_IP" {
  value = aws_instance.Ansible_Web_Server.public_ip
}

output "Ansible_Appserver_Public_IP" {
  value = aws_instance.Ansible_App_Server.public_ip
}
