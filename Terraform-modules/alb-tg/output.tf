output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer."
  value       = aws_lb.frontend-aws-alb.dns_name
}

output "alb_id" {
  value = aws_lb.frontend-aws-alb.id
}

output "alb_name" {
  value = aws_lb.frontend-aws-alb.name
}

output "zone_id" {
  description = "Alb hosted zone id"
  value       = aws_lb.frontend-aws-alb.zone_id
}

output "frontend_tg_arn" {
  description = "ARN of the target group."
  value       = aws_lb_target_group.frontend-target-group.arn
}

output "security_group_id" {
  description = "ID of the security group for the ALB."
  value       = aws_security_group.frontend-alb-sg.id
}

output "aws_lb_arn" {
  description = "ARN of LoadBalancer"
  value       = aws_lb.frontend-aws-alb.arn
}
