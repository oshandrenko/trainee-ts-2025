output "vpc_id" {
  description = "ID VPC"
  value       = aws_vpc.main.id
}

output "instance_ids" {
  description = "ID инстансов EC2"
  value       = aws_instance.db_instance[*].id
}

output "instance_public_ips" {
  description = "Публичные IP инстансов"
  value       = aws_instance.db_instance[*].public_ip
}
