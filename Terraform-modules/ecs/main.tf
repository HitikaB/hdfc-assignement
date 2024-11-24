resource "aws_security_group" "ecs_tasks" {
  name        = "${var.project}-${var.env}-${var.app_name}-ecs-sg"
  description = "allow inbound access from the ALB only"
  vpc_id      = var.frontend_vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.app_port
    to_port         = var.app_port
    security_groups = var.frontend_alb_sg
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_cluster" "main" {
  name = "${var.project}-${var.env}-${var.app_name}-cluster"
}

data "template_file" "frontend" {
  template = file("${path.module}/templates/frontend.json.tpl")

  vars = {
    app_name         = var.app_name
    app_image        = var.app_image
    app_port         = var.app_port
    container_cpu    = var.frontend_cpu
    container_memory = var.frontend_memory
    log_group        = "${var.project}-${var.env}-${var.app_name}-task"
    aws_region       = var.aws_region
  }
}

resource "aws_ecs_task_definition" "frontend" {
  family                   = "${var.project}-${var.env}-${var.app_name}-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = var.network_mode
  requires_compatibilities = var.compatibility
  cpu                      = var.frontend_task_cpu
  memory                   = var.frontend_task_memory
  container_definitions    = data.template_file.frontend.rendered
}

# resource "aws_ecs_service" "frontend" {
#   name            = "${var.project}-${var.env}-${var.app_name}-service"
#   cluster         = aws_ecs_cluster.main.id
#   task_definition = aws_ecs_task_definition.frontend.arn
#   desired_count   = var.app_count
#   launch_type     = var.launch_type

#   network_configuration {
#     security_groups  = [aws_security_group.ecs_tasks.id]
#     subnets          = var.frontend_private_subnets
#     assign_public_ip = true
#   }

#   load_balancer {
#     target_group_arn = var.frontend_target_group_arn
#     container_name   = var.app_name
#     container_port   = var.app_port
#   }

#   depends_on = [aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment]
# }