variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

#vpc:

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_instance_tenancy" {
  description = "Instance tenancy for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

#availability_zones:

variable "availability_zone_1" {
  description = "Availability Zone for Subnet 01"
  type        = string
}

variable "availability_zone_2" {
  description = "Availability Zone for Subnet 02"
  type        = string
}


#public_subnets:

variable "pub_subnet1_cidr" {
  description = "cidr block for Subnet 01"
  type        = string
}

variable "pub_subnet1_name" {
  description = "Name tag for the Subnet 01"
  type        = string
}

variable "pub_subnet2_cidr" {
  description = "cidr block for Subnet 02"
  type        = string
}

variable "pub_subnet2_name" {
  description = "Name tag for the Subnet 02"
  type        = string
}


#private_subnets:

variable "priv_subnet1_cidr" {
  description = "cidr block for Subnet 03"
  type        = string
}

variable "priv_subnet1_name" {
  description = "Name tag for the Subnet 03"
  type        = string
}

variable "priv_subnet2_cidr" {
  description = "cidr block for Subnet 04"
  type        = string
}

variable "priv_subnet2_name" {
  description = "Name tag for the Subnet 04"
  type        = string
}


# public_route_table:

variable "pub_route_table_name" {
  description = "Name tag for the public route table"
  type        = string
}


# private_route_table:

variable "priv_route_table_name" {
  description = "Name tag for the private route table"
  type        = string
}
