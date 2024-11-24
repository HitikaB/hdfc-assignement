output "frontend_repository_url" {
  value       = aws_ecr_repository.frontend_ecr_repository.repository_url
  description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName)."
}

output "frontend_registry_id" {
  value       = aws_ecr_repository.frontend_ecr_repository.registry_id
  description = "The registry ID where the repository was created."
}
