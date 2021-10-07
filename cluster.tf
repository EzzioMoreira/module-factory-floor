resource "aws_ecs_cluster" "main" {
  name = var.environment

  tags = var.default_tags
}