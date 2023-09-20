output "connection_strings" {
  value = mongodbatlas_cluster.my_cluster.connection_strings.0.standard_srv
  #value = mongodbatlas_cluster.my_cluster.connection_strings.0.standard
}

output "private_srv" {
    value = mongodbatlas_cluster.my_cluster.connection_strings[0].private_srv
}