output "connection_strings" {
  value = module.database.connection_strings
}

output "db_user" {
  description = "Database user id!"
  value       = module.user.user_id
}

output "db_user_password" {
  description = "Database password. Do not share!"
  sensitive   = true
  value       = module.user.user_password
}

output "mongo_vpc_id" {
  value = module.project.mongo_container_vpc
}

output "datadog_integration_id" {
  description = "The ID of the Datadog integration"
  value       = var.enable_datadog_integration ? module.datadog_integration.datadog_integration_id : null
}
