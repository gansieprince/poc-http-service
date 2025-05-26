resource "aws_ecr_repository" "http_ecr_repo" {
  name                 = "${local.name}-offerzen"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}