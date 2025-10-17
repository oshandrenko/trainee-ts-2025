output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_a_id" {
  description = "ID of subnet A"
  value       = aws_subnet.subnet_a.id
}

output "blue_instance_public_ips" {
  description = "Public IPs of Blue EC2 instances"
  value       = module.ec2_blue[*].public_ip
}

output "green_instance_public_ips" {
  description = "Public IPs of Green EC2 instances"
  value       = module.ec2_green[*].public_ip
}

output "nlb_dns_name" {
  description = "DNS name of the NLB"
  value       = aws_lb.nlb.dns_name
}

output "active_target_group" {
  description = "ARN of target group"
  value       = var.active_color == "blue" ? aws_lb_target_group.blue_tg.arn : aws_lb_target_group.green_tg.arn
}
