output "connection_strings" {
  description = "Set of connection strings that your applications use to connect to this cluster"
  value       = mongodbatlas_cluster.my_cluster.connection_strings.0.standard_srv
}

output "cluster_id" {
  description = "The cluster ID."
  value       = mongodbatlas_cluster.my_cluster.cluster_id
}

output "state_name" {
  description = "Current state of the cluster"
  value       = mongodbatlas_cluster.my_cluster.state_name
}

output "mongo_uri" {
  description = "Base connection string for the cluster. Atlas only displays this field after the cluster is operational, not while it builds the cluster."
  value       = mongodbatlas_cluster.my_cluster.mongo_uri
}