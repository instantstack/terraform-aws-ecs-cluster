data "aws_ecs_cluster" "this" {
  count = var.create_ecs_cluster == false && var.existing_ecs_cluster == true ? 1 : 0

  cluster_name = var.name
}

resource "aws_ecs_cluster" "main" {
  count = var.create_ecs_cluster == true ? 1 : 0

  name = var.name

  setting {
    name  = "containerInsights"
    value = var.container_insights
  }

  tags = var.tags
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  count = var.create_ecs_cluster == true ? 1 : 0

  cluster_name = aws_ecs_cluster.main.0.name

  capacity_providers = var.capacity_providers

  dynamic "default_capacity_provider_strategy" {
    for_each = var.default_capacity_provider_strategy != null ? [1] : []

    content {
      capacity_provider = var.default_capacity_provider_strategy.capacity_provider
      weight            = lookup(var.default_capacity_provider_strategy, "weight", 0)
      base              = lookup(var.default_capacity_provider_strategy, "base", 0)
    }
  }
}