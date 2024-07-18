output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.instance.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.instance.public_ip
}

output "security_group_id" {
  value       = aws_security_group.ec2_sg.id
  description = "ID of the created security group"
} 