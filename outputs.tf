output "id" {
  value       = try(data.aws_ecs_cluster.this.0.arn, try(aws_ecs_cluster.main.0.id, null))
  description = "The Amazon Resource Name (ARN) that identifies the cluster."
}
