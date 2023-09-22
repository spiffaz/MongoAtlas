#resource "mongodbatlas_third_party_integration" "datadog_integration" {
#  project_id = mongodbatlas_project.mongo_project.id
#  type       = "DATADOG"
#  api_key    = local.datadog_api_key
#  region     = var.datadog_region
#}