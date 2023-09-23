variable "enable_datadog_integration" {
  description = "Set to true to enable Datadog integration."
  default     = false
}

variable "mongodb_atlas_api_pub_key" {
  type = string
}

variable "mongodb_atlas_api_pri_key" {
  type = string
}

variable "project_id" {
  description = "The MongoDB Atlas Project ID"
}

variable "datadog_api_key" {
  description = "Datadog API Key"
}

variable "datadog_region" {
  description = "Datadog region"
}
