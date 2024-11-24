variable "project" {
  type        = string
  description = "The name of the project"
}

variable "env" {
  type        = string
  description = "The environment name (e.g., dev, prod)"
}

variable "frontend_vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "frontend_alb_sg" {
  type        = list(string)
  description = "The security group(s) for the ALB"
}

variable "app_port" {
  type        = number
  description = "The port on which the application listens"
}


variable "app_name" {
  type        = string
  description = "The name of the ECS container"
}

variable "app_image" {
  type        = string
  description = "The Docker image for the application"
}

variable "frontend_cpu" {
  type        = string
  description = "The CPU units for the conatiner"
}

variable "frontend_memory" {
  type        = string
  description = "The memory for the container"
}

variable "aws_region" {
  type        = string
  description = "The AWS region"
}

variable "frontend_task_cpu" {
  type        = string
  description = "The CPU units for the ECS task"
}

variable "frontend_task_memory" {
  type        = string
  description = "The memory for the ECS task"
}

variable "app_count" {
  type        = number
  description = "The desired number of tasks for the ECS service"
}

variable "compatibility" {
  description = "Launch Compatibities"
}

variable "frontend_private_subnets" {
  type        = list(string)
  description = "The private subnets for the ECS service"
}

variable "frontend_target_group_arn" {
  type        = string
  description = "The ARN of the target group for the ALB"
}

variable "launch_type" {
  description = "Launch type for ECS service"
}

variable "network_mode" {
  description = "Network Mode"
}
