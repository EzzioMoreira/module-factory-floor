output "vpc_id" {
  value = aws_vpc.main.id
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "subnet_private" {
  value = aws_subnet.private[*].cidr_block
}

output "subnet_public" {
  value = aws_subnet.public[*].cidr_block
}