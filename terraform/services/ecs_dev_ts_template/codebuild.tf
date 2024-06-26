################################################################################
# CodeBuild
################################################################################
resource "aws_codebuild_project" "main" {
  name           = "codebuild-${local.name}"
  service_role   = aws_iam_role.codebuild.arn
  build_timeout  = 60
  source_version = "develop"
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "GIT_ASKPASS"
      type  = "PLAINTEXT"
      value = "/usr/local/bin/git-askpass-helper"
    }

    environment_variable {
      name  = "BITBUCKET_OAUTH_TOKEN"
      type  = "PLAINTEXT"
      value = aws_codebuild_source_credential.main.token
    }
  }

  source {
    buildspec = templatefile("${path.module}/buildspec/buildspec.yaml", {
      account_id      = data.aws_caller_identity.current.id
      region          = var.region
      repository_name = aws_ecr_repository.main.name
      repository_url  = aws_ecr_repository.main.repository_url
      version         = local.version
    })
    type                = "BITBUCKET"
    location            = local.bitbucket_repository_url
    git_clone_depth     = 1
    report_build_status = true

    git_submodules_config {
      fetch_submodules = false
    }
  }

  lifecycle {
    ignore_changes = [project_visibility]
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }
}

resource "aws_codebuild_source_credential" "main" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "BITBUCKET"
  token       = var.bitbucket_access_token
}

resource "aws_codebuild_webhook" "main" {
  project_name = aws_codebuild_project.main.name
  build_type   = "BUILD"
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }
    filter {
      type    = "HEAD_REF"
      pattern = "develop"
    }
  }
}
