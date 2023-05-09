resource "aws_instance" "jenkins-server" {
    ami           = var.jenkins-aim
    instance_type = var.instance_type
    key_name = "test"
    security_groups  = [aws_security_group.jenkins_traffic.name] 
    tags = {
    Name = "jenkins_server"
}
provisioner "remote-exec" {
    inline = [
        "sudo yum update –y",
        "sudo yum  -y  install wget",
        "sudo wget -O /etc/yum.repos.d/jenkins.repo  https://pkg.jenkins.io/redhat-stable/jenkins.repo",
        "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",
        "sudo yum upgrade -y",
        "sudo yum install java-11-amazon-corretto -y",
        "sudo yum install jenkins -y",
        "sudo systemctl enable jenkins",
        "sudo systemctl start jenkins",
    ]

connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key= "${file("./key/test.pem")}"
    host     = self.public_ip
}

}
}

# resource "tls_private_key" "pk" {
# algorithm = "RSA"
# rsa_bits  = 4096
# }

# resource "aws_key_pair" "deployer" {
# key_name   = "jenkins"
# public_key = var.public_key

#     provisioner "local-exec" {
#     command = "echo ${tls_private_key.pk.private_key_pem} > ./jenkins.pem"
    
# }
# }
