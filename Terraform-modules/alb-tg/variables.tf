variable "frontend_vpc_id" {
  description = "ID of the VPC where the resources will be created."
}

variable "frontend-subnet1" {
  description = "ID of the first subnet where the ALB will be deployed."
}

variable "frontend-subnet2" {
  description = "ID of the second subnet where the ALB will be deployed."
}

variable "project" {
  description = "Project Name"
}

variable "env" {
  description = "Environment"
}

variable "arn" {
  description = "Certificate ARN"
}