variable "mongodb_atlas_api_pub_key" {
  type = string
}

variable "mongodb_atlas_api_pri_key" {
  type = string
}

variable "project_id" {
  description = "The MongoDB Atlas Project ID"
}

variable "username" {
  description = "The username for the MongoDB Atlas user"
  type        = string
  default     = "Admin"
}

variable "auth_database_name" {
  description = "Authentication database"
  type        = string
  default     = "admin"
}

variable "database_role_name" {
  description = "Role to assign to database user"
  type        = string
  default     = "atlasAdmin"
}

variable "database_name_to_give_access" {
  description = "Database to give access to"
  type        = string
  default     = "admin"
}

variable "user_password_length" {
  description = "Length of generated password"
  type        = number
  default     = 16
}

variable "allow_special_characters" {
  description = "Allow special characters in password?"
  type        = bool
  default     = false
}