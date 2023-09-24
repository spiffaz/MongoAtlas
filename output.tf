# database
output "connection_strings" {
  value = module.mongodb_atlas.connection_strings
}

output "cluster_id" {
  description = "The cluster ID."
  value       = module.mongodb_atlas.cluster_id
}

output "state_name" {
  description = "Current state of the cluster"
  value = module.mongodb_atlas.state_name
}

output "mongo_uri" {
  description = "Base connection string for the cluster. Atlas only displays this field after the cluster is operational, not while it builds the cluster."
  value       = module.mongodb_atlas.mongo_uri
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