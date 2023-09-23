output "connection_strings" {
  description = "value"
  value       = mongodbatlas_cluster.my_cluster.connection_strings.0.standard_srv
}