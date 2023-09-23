output "connection_strings" {
  value = module.mongodb_atlas.connection_strings
}

output "db_user_password" {
  description = "Database password. Do not share!"
  sensitive   = true
  value       = module.mongodb_atlas.db_user_password
}

output "mongo_vpc_id" {
  value = module.mongodb_atlas.mongo_vpc_id
}

output "datadog_integration_id" {
  description = "The ID of the Datadog integration"
  value       = var.enable_datadog_integration ? module.mongodb_atlas[0].id : null
}