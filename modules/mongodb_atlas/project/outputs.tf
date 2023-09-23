output "project_id" {
  description = "The MongoDB Atlas Project ID"
  value       = mongodbatlas_project.mongo_project.id
}

output "mongo_container_vpc" {
  description = "The vpc id of the mongo container"
  value       = var.enable_network_peering ? mongodbatlas_network_container.mongo_container[0].vpc_id : null
}