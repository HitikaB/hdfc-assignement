resource "aws_ecr_repository" "frontend_ecr_repository" {
  name                 = "${var.project}-${var.environment}-frontend"
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = merge(
    var.additional_tags,
    {
      ManagedBy   = "Terraform"
      Environment = "${var.environment}"
    }
  )
}

resource "aws_ecr_lifecycle_policy" "frontend_ecr_policy" {
  count      = var.expiration_after_days > 0 ? 1 : 0
  repository = aws_ecr_repository.frontend_ecr_repository.name
  policy     = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than ${var.expiration_after_days} days",
            "selection": {
                "tagStatus": "any",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": ${var.expiration_after_days}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}