output "ecr_image_url" {
  value = aws_ecr_repository.ecr_repository.repository_url
}
