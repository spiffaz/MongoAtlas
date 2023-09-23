output "datadog_integration_id" {
  description = "The ID of the Datadog integration"
  value       = var.enable_datadog_integration ? mongodbatlas_third_party_integration.datadog_integration[0].id : null
}