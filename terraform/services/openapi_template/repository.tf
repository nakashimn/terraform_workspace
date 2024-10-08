################################################################################
# Repository
################################################################################
# ECR定義
resource "aws_ecr_repository" "main" {
  name                 = local.repository_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}
