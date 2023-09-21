output "connection_strings" {
  value = mongodbatlas_cluster.my_cluster.connection_strings.0.standard_srv
  #value = mongodbatlas_cluster.my_cluster.connection_strings.0.standard
}

output "private_srv" {
  value = mongodbatlas_cluster.my_cluster.connection_strings[0].private_srv
}

output "container_vpc" {
  value = mongodbatlas_network_container.test.vpc_id
}

output "db_user_password" {
  description = "Database password.  Do not share!"
  sensitive   = true
  value       = random_password.user_password.result
}