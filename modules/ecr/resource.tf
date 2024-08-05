resource "aws_ecr_repository" "ecr_repository" {
  name                 = var.repository_names
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = merge(var.common_tags, var.repository_tags)
}


# resource "null_resource" "docker_image_to_ecr" {
#   provisioner "local-exec" {
#     command = <<EOF
#       aws --profile ${var.aws_profile} ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com

#       docker build -t "${aws_ecr_repository.ecr_repository.repository_url}:latest" -f ${var.path_to_dockerfile} ${var.docker_context}
#       docker push "${aws_ecr_repository.ecr_repository.repository_url}:latest"
#     EOF
#   }

#   triggers = {
#     "run_at" = timestamp()
#   }

#   depends_on = [
#     aws_ecr_repository.ecr_repository,
#   ]
# }

