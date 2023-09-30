package test

import (
	"fmt"
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"path/filepath"
	"os"
)

func TestTerraformMongoDBAtlasClusterCreation(t *testing.T) {
	t.Parallel()

	// Map and confirm environment variables
	AWS_ACCESS_KEY := os.Getenv("AWS_ACCESS_KEY")
	if AWS_ACCESS_KEY == "" {
		t.Fatal("AWS_ACCESS_KEY environment variable not set")
	}

	AWS_SECRET_KEY := os.Getenv("AWS_SECRET_KEY")
	if AWS_SECRET_KEY == "" {
		t.Fatal("AWS_SECRET_KEY environment variable not set")
	}


	// Create a temporary directory for the test
    testDir := t.TempDir()
	fmt.Println(string(testDir))

	// Set the path to the Terraform code that will be tested.
    modulePath := filepath.Join("..", "modules", "mongodb_atlas")

	fmt.Println("modulePath =",string(modulePath))

	terraformOptions := &terraform.Options{
		TerraformDir: modulePath,
		EnvVars: map[string]string{
			"AWS_ACCESS_KEY"         : AWS_ACCESS_KEY,

			"TF_VAR_projectName"     : "my_project",
            "TF_VAR_datadog_region"  : "US",
            "TF_VAR_aws_region"      : "us-east-1",
            "TF_VAR_aws_vpc_cidr"    : "10.0.0.0/24",
            "TF_VAR_datadog_api_key" : "ENTER_KEY",
            
            "TF_VAR_mongodb_atlas_api_pub_key" : "hnywtikb",
            "TF_VAR_mongodb_atlas_api_pri_key" : "829f3686-961d-47c8-af93-c3fb8dd259b6",
            "TF_VAR_mongodb_atlas_org_id"      : "6508ba36b74ab34c5b994349",
            
            "TF_VAR_aws_account_id" : "974428303826",
            
            "TF_VAR_mongodb_atlas_accesslistip"                     : "105.112.183.137",
            "TF_VAR_enable_mongodb_atlas_accesslist_security_group" : "false",
            "TF_VAR_mongodb_atlas_accesslist_security_group_id"     : "default_value",
            
            "TF_VAR_enable_network_peering"     : "false" ,    // Optionally enable network peering
            "TF_VAR_enable_datadog_integration" : "false" ,// Optionally enable Datadog integration
            
            // Project configuration
            "TF_VAR_is_collect_database_specifics_statistics_enabled" : "true",
            "TF_VAR_is_data_explorer_enabled"                         : "true",
            "TF_VAR_is_performance_advisor_enabled"                   : "true",
            "TF_VAR_is_realtime_performance_panel_enabled"            : "true",
            "TF_VAR_is_schema_advisor_enabled"                        : "true",
            
            "TF_VAR_maintenance_window_day_of_week" : "4",
            "TF_VAR_maintenance_window_hour_of_day" : "2",
            
            // If network peering is enabled
            "TF_VAR_atlas_network_container_cidr_block" : "10.8.0.0/21",
            
            // Database configuration
            "TF_VAR_database_name"                  : "admin",
            "TF_VAR_atlas_provider_name"            : "TENANT",
            "TF_VAR_atlas_backing_provider_name"    : "AWS",
            "TF_VAR_provider_instance_size_name"    : "M0",
            "TF_VAR_provider_region_name"           : "US_EAST_1",
            "TF_VAR_mongo_db_major_version"         : "6.0",
            "TF_VAR_auto_scaling_disk_gb_enabled"   : "true",
            "TF_VAR_termination_protection_enabled" : "false",

            // User configuration
            "TF_VAR_username"                     : "Admin",
            "TF_VAR_auth_database_name"           : "admin",
            "TF_VAR_database_role_name"           : "atlasAdmin",
            "TF_VAR_database_name_to_give_access" : "admin",
            "TF_VAR_user_password_length"         : "16",
            "TF_VAR_allow_special_characters"     : "false",
        },
	}

	// Apply the Terraform configuration.
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Get the output values from Terraform.
	actualClusterID := terraform.Output(t, terraformOptions, "cluster_id")
	actualConnectionStrings := terraform.Output(t, terraformOptions, "connection_strings")
	actualDBUser := terraform.Output(t, terraformOptions, "db_user")

	// Assert that the cluster ID is not empty, confirming cluster creation.
	assert.NotEmpty(t, actualClusterID, "Cluster ID should not be empty")

	// Assert that the connection strings are not empty, confirming cluster creation.
	assert.NotEmpty(t, actualConnectionStrings, "Connection strings should not be empty")

	// Assert that the DB user is not empty, confirming user creation.
	assert.NotEmpty(t, actualDBUser, "DB user should not be empty")

}
