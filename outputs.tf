output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.vpn_server.id
}

output "public_ip" {
  description = "The public IP of the instance (null if is_public is false)"
  value       = var.is_public ? aws_instance.vpn_server.public_ip : null
}

output "security_group_id" {
  description = "The ID of the security group created"
  value       = aws_security_group.vpn_sg.id
}