projectName     = "my_project"
datadog_region  = "US"
aws_region      = "us-east-1"
aws_vpc_cidr    = "10.0.0.0/24"
datadog_api_key = "ENTER_KEY"

mongodb_atlas_api_pub_key = "hnywtikb"
mongodb_atlas_api_pri_key = "829f3686-961d-47c8-af93-c3fb8dd259b6"
mongodb_atlas_org_id      = "6508ba36b74ab34c5b994349"

aws_account_id = ""

mongodb_atlas_accesslistip                     = "105.112.183.137"
enable_mongodb_atlas_accesslist_security_group = false
mongodb_atlas_accesslist_security_group_id     = "default_value"

enable_network_peering     = false # Optionally enable network peering
enable_datadog_integration = false # Optionally enable Datadog integration

# Project configuration
is_collect_database_specifics_statistics_enabled = true
is_data_explorer_enabled                         = true
is_performance_advisor_enabled                   = true
is_realtime_performance_panel_enabled            = true
is_schema_advisor_enabled                        = true

maintenance_window_day_of_week = 4
maintenance_window_hour_of_day = 2

# If network peering is enabled
atlas_network_container_cidr_block = "10.8.0.0/21"

# Database configuration
database_name                  = "admin"
atlas_provider_name            = "TENANT"
atlas_backing_provider_name    = "AWS"
provider_instance_size_name    = "M0"
provider_region_name           = "US_EAST_1"
mongo_db_major_version         = "6.0"
auto_scaling_disk_gb_enabled   = true
termination_protection_enabled = false

# User configuration
username                     = "Admin"
auth_database_name           = "admin"
database_role_name           = "atlasAdmin"
database_name_to_give_access = "admin"
user_password_length         = "16"
allow_special_characters     = false