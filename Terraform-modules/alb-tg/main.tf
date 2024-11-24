resource "aws_security_group" "frontend-alb-sg" {
  name   = "rwc-b2c-${var.env}-frontend-alb-asg"
  vpc_id = var.frontend_vpc_id
}

resource "aws_security_group_rule" "inbound_http" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.frontend-alb-sg.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "inbound_https" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.frontend-alb-sg.id
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "outbound_all" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.frontend-alb-sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

#LoadBalancer
resource "aws_lb" "frontend-aws-alb" {
  name     = "${var.project}-${var.env}-frontend-alb"
  internal = false

  security_groups = [
    "${aws_security_group.frontend-alb-sg.id}",
  ]

  subnets = [
    "${var.frontend-subnet1}",
    "${var.frontend-subnet2}"
  ]

  tags = {
    Name = "${var.project}-${var.env}-frontend-alb"
  }

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_listener" "http-alb-listner" {
  load_balancer_arn = aws_lb.frontend-aws-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "https-alb-listner" {
  load_balancer_arn = aws_lb.frontend-aws-alb.arn
  certificate_arn   = var.arn
  port              = 443
  protocol          = "HTTPS"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener_rule" "frontend-alb-host-rule" {
  listener_arn = aws_lb_listener.https-alb-listner.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-target-group.arn
  }

  condition {
    host_header {
      values = ["livev3.arktravelgroups.com"]
    }
  }
}

resource "aws_lb_listener_rule" "frontend-alb-host-rule2" {
  listener_arn = aws_lb_listener.https-alb-listner.arn
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-target-group2.arn
  }

  condition {
    host_header {
      values = ["livev3.arktravelgroups.com"]
    }
  }
}

#Target-group
resource "aws_lb_target_group" "frontend-target-group" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "${var.project}-${var.env}-frontend-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.frontend_vpc_id
}

resource "aws_lb_target_group" "frontend-target-group2" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "${var.project}-${var.env}-frontend-tg2"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.frontend_vpc_id
}