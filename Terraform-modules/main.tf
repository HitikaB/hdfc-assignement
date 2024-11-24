provider "aws" {
  profile = "home"
  region  = "us-east-1"
}

module "vpc" {
  source                = "./vpc"
  vpc_cidr_block        = "10.0.0.0/16"
  vpc_instance_tenancy  = "default"
  vpc_name              = "vpc-tf"
  availability_zone_1   = "us-east-1a"
  availability_zone_2   = "us-east-1b"
  pub_subnet1_cidr      = "10.0.1.0/24"
  pub_subnet1_name      = "tf-pub1-subnet"
  pub_subnet2_cidr      = "10.0.3.0/24"
  pub_subnet2_name      = "tf-pub2-subnet"
  priv_subnet1_cidr     = "10.0.2.0/24"
  priv_subnet1_name     = "tf-pri1-subnet"
  priv_subnet2_cidr     = "10.0.4.0/24"
  priv_subnet2_name     = "tf-pri2-subnet"
  pub_route_table_name  = "tf-pubroute"
  priv_route_table_name = "tf-priroute"
}


module "ec2" {
  source                = "./ec2"
  instance_ami          = "ami-04a81a99f5ec58529"
  bastion_instance_type = "t2.micro"
  vpc                   = module.vpc.vpc_id
  key_name              = "test-key"
  pubsecgrp             = "tf-bastion-sg"
  pub_instance_name     = "tf-bastion-host"
  public_subnet_id      = module.vpc.subnet01_id
}

variable "db_password" {}

module "rds" {
  source                   = "./rds"
  aws_region               = "us-east-1"
  db_instance_identifier   = "tf-db"
  rds_storage_type         = "gp2"
  allocated_storage        = 20
  db_username              = "admin"
  db_password              = var.db_password
  rds_publicly_accessible  = false
  security_group_name      = "tf-rds-sg"
  security_group_cidr      = "0.0.0.0/0"
  rds_engine               = "mysql"
  rds_engine_version       = "8.0.35"
  rds_instance_class       = "db.t3.micro"
  rds_parameter_group_name = "default.mysql8.0"
  rds_skip_final_snapshot  = true
  rds_option_group_name    = "default:mysql-8-0"
  db_subnet_group          = [module.vpc.subnet03_id, module.vpc.subnet04_id]
  vpc_id                   = module.vpc.vpc_id
}

module "ecr" {
  source                = "./ecr"
  project               = "hdfc"
  environment           = "test"
  image_tag_mutability  = "IMMUTABLE"
  scan_on_push          = false
  expiration_after_days = 15
}

module "alb" {
  source           = "./alb-tg"
  project          = "hdfc"
  env              = "test"
  arn              = "arn:aws:acm:us-east-1:339712975105:certificate/4daaddad-3a66-4201-908c-e23a0c7d2dcc"
  frontend_vpc_id  = module.vpc.vpc_id
  frontend-subnet1 = module.vpc.subnet01_id
  frontend-subnet2 = module.vpc.subnet02_id
}

module "ecs" {
  source                    = "./ecs"
  project                   = "hdfc"
  env                       = "test"
  frontend_vpc_id           = module.vpc.vpc_id
  frontend_alb_sg           = [module.alb.security_group_id]
  frontend_private_subnets  = [module.vpc.subnet03_id, module.vpc.subnet04_id]
  aws_region                = "us-east-1"
  app_count                 = 1
  compatibility             = ["FARGATE"]
  launch_type               = "FARGATE"
  network_mode              = "awsvpc"
  frontend_task_cpu         = 1024
  frontend_task_memory      = 2048
  app_port                  = 3000
  app_name                  = "frontend"
  app_image                 = module.ecr.frontend_repository_url
  frontend_cpu              = 512
  frontend_memory           = 1024
  frontend_target_group_arn = module.alb.frontend_tg_arn
}

