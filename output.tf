output "connection_strings" {
  value = mongodbatlas_cluster.my_cluster.connection_strings.0.standard_srv
  #value = mongodbatlas_cluster.my_cluster.connection_strings.0.standard
}

output "db_user_password" {
  description = "Database password. Do not share!"
  sensitive   = true
  value       = random_password.user_password.result
}

output "mongo_vpc_id" {
  value = mongodbatlas_network_container.mongo_container.vpc_id
}