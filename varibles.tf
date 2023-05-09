variable "region" {
    type = string
}
variable "jenkins-aim" {
    type = string
}
variable "instance_type" {
    type = string
}
variable "ingressrules" {
    type = list (number)
}
variable "public_key" {
description = "ssh public key "
} 