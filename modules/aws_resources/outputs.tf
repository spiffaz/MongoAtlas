output "aws_vpc_id" {
  description = "The ID of the AWS VPC"
  value       = var.enable_network_peering ? aws_vpc.primary.id : null
}

output "aws_internet_gateway_id" {
  description = "The ID of the AWS Internet Gateway"
  value       = var.enable_network_peering ? aws_internet_gateway.primary.id : null
}

output "aws_subnet_id" {
  description = "The ID of the AWS Subnet"
  value       = var.enable_network_peering ? aws_subnet.az1.id : null
}

output "aws_security_group_id" {
  description = "The ID of the AWS Security Group"
  value       = var.enable_network_peering ? aws_security_group.primary_default.id : null
}
