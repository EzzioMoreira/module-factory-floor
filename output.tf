output "vpc_id" {
  value = aws_vpc.main.id
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "subnet.private" {
  value = aws_subnet.private[*].cidr_block
}