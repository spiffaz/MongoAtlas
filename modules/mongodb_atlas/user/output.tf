output "user_id" {
  description = "The MongoDB Atlas User ID"
  value       = mongodbatlas_database_user.mongo_user.id
}

output "user_password" {
  description = "The password of the created user"
  value       = random_password.user_password.result
}