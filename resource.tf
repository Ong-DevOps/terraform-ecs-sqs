## Build docker images and push to ECR
resource "docker_registry_image" "backend" {
  name          = docker_image.image.name
  keep_remotely = false

}

resource "docker_image" "image" {
  name = "${module.ecr.ecr_image_url}:latest"
  build {
    context    = var.docker_context  ##  "../docker-image-nginx/"
    dockerfile = var.docker_filename ## "Dockerfile"
  }
}
