variable "mongodb_atlas_api_pub_key" {
  type = string
}

variable "mongodb_atlas_api_pri_key" {
  type = string
}

variable "project_id" {
  description = "The MongoDB Atlas Project ID"
}

variable "database_name" {
  description = "The name of the MongoDB Atlas Database"
}

variable "atlas_provider_name" {
  description = "provider to be used in creating atlas cluster"
  default     = "TENANT"
}

variable "atlas_backing_provider_name" {
  description = "backing provider for creating atlas cluser. used when TENANT is the main provider"
  type        = string
  default     = "AWS"
}

variable "provider_instance_size_name" {
  description = "The size of the Atlas instance to be created"
  type        = string
  default     = "M0"
}

variable "provider_region_name" {
  description = "The region of the provider where the cluster will be provisioned"
  type        = string
  default     = "US_EAST_1"
}

variable "mongo_db_major_version" {
  description = "Mongo db version"
  type        = number
  default     = "5.0"
}

variable "auto_scaling_disk_gb_enabled" {
  description = "Is disk automatic scaling enabled?"
  type        = bool
  default     = true
}

variable "termination_protection_enabled" {
  description = "Database protection from deletion enabled?"
  type        = bool
  default     = false
}