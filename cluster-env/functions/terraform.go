package functions

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"
)

func SetNamespaceTF(namespace string) {
	getSSMParam := func(paramName string) string {
		cmd := exec.Command("aws", "ssm", "get-parameter", "--name", paramName, "--with-decryption", "--profile", "moj-cp", "--query", "Parameter.Value", "--output", "text")
		out, err := cmd.Output()
		if err != nil {
			log.Fatalf("Failed to get SSM parameter %s: %v", paramName, err)
		}
		return strings.TrimSpace(string(out))
	}

	os.Setenv("TF_VAR_github_cloud_platform_concourse_bot_app_id", getSSMParam("/cloud-platform/infrastructure/components/github_cloud_platform_concourse_bot_app_id"))
	os.Setenv("TF_VAR_github_cloud_platform_concourse_bot_installation_id", getSSMParam("/cloud-platform/infrastructure/components/github_cloud_platform_concourse_bot_installation_id"))
	os.Setenv("TF_VAR_github_cloud_platform_concourse_bot_pem_file", getSSMParam("/cloud-platform/infrastructure/components/github_cloud_platform_concourse_bot_pem_file"))
	os.Setenv("PIPELINE_STATE_BUCKET", "cloud-platform-terraform-state")
	os.Setenv("PIPELINE_STATE_KEY_PREFIX", "cloud-platform-environments")
	os.Setenv("PIPELINE_TERRAFORM_STATE_LOCK_TABLE", "cloud-platform-environments-terraform-lock")
	os.Setenv("PIPELINE_STATE_REGION", "eu-west-1")
	os.Setenv("PIPELINE_CLUSTER", "arn:aws:eks:eu-west-2:754256621582:cluster/live")
	os.Setenv("PIPELINE_CLUSTER_DIR", "live.cloud-platform.service.justice.gov.uk")
	os.Setenv("PIPELINE_CLUSTER_STATE", "live-1.cloud-platform.service.justice.gov.uk")
	os.Setenv("PIPELINE_STATE_KEY_PREFIX", fmt.Sprintf("cloud-platform-environments/live-1.cloud-platform.service.justice.gov.uk/%v/terraform.tfstate", namespace))
	os.Setenv("TF_VAR_cluster_name", "live-1")
	os.Setenv("TF_VAR_vpc_name", "live-1")
	os.Setenv("TF_VAR_eks_cluster_name", "live")
	os.Setenv("TF_VAR_cluster_state_bucket", "cloud-platform-terraform-state")
	os.Setenv("TF_VAR_github_owner", "ministryofjustice")
	os.Setenv("TF_VAR_kubernetes_cluster", "DF366E49809688A3B16EEC29707D8C09.gr7.eu-west-2.eks.amazonaws.com")
	os.Setenv("PINGDOM_API_TOKEN", getSSMParam("/cloud-platform/infrastructure/components/pingdom_api_token"))
}

func SetTFWksp(clusterName string) error {
	// tf workspace to the cluster name
	fmt.Println(string(utils.Yellow), "\nUpdating Terraform Workspace", string(utils.Reset))
	err := os.Setenv("TF_WORKSPACE", clusterName)
	if err != nil {
		return err
	} else {
		fmt.Println(string(utils.Cyan), "TF_WORKSPACE:", string(utils.Reset), os.Getenv("TF_WORKSPACE"))
	}
	return nil
}
