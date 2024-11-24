variable "instance_ami" {
  description = "AMI ID for the private EC2 instance"
}

variable "bastion_instance_type" {
  description = "Instance type for the public EC2 instance"
}

variable "key_name" {
  description = "Key for accessing EC2"
}

variable "vpc" {
  description = "Vpc for Security group"
}

variable "pubsecgrp" {
  description = "Public Instance Security group name"
}

variable "pub_instance_name" {
  description = "Name for the public EC2 instance"
}

variable "public_subnet_id" {
  description = "Subnet for EC2"
}
