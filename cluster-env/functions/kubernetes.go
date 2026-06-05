package functions

import (
	"context"
	"fmt"
	"os"
	"slices"
	"strings"

	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/eks"
)

func SetKubeEnv(profile, clusterName string) bool {
	var returnOuput bool
	fmt.Println(string(utils.Yellow), "\nSetting Kube Configuration", string(utils.Reset))

	switch {
	case strings.Contains(clusterName, "cp"):
		utils.kubeConfig = utils.home + "/.kube/development_clusters/" + clusterName + "/config"
		returnOuput = true
	case (profile == "cp-dev" && clusterName == "development") || (profile == "cp-preprod" && clusterName == "preproduction") || (profile == "cp-nonlive" && clusterName == "nonlive") || (profile == "cp-live" && clusterName == "live"):
		utils.kubeConfig = utils.home + "/.kube/account_clusters/" + clusterName + "/config"
		returnOuput = true
	default:
		return false
	}

	os.Setenv("KUBECONFIG", utils.kubeConfig)

	os.Setenv("KUBE_CONFIG", os.Getenv("KUBECONFIG"))
	os.Setenv("KUBE_CONFIG_PATH", os.Getenv("KUBECONFIG"))

	fmt.Println(string(utils.Cyan), "KUBECONFIG:", string(utils.Reset), os.Getenv("KUBECONFIG"))
	fmt.Println(string(utils.Cyan), "KUBE_CONFIG:", string(utils.Reset), os.Getenv("KUBE_CONFIG"))
	fmt.Println(string(utils.Cyan), "KUBE_CONFIG_PATH:", string(utils.Reset), os.Getenv("KUBE_CONFIG_PATH"))

	return returnOuput
}

func ListEksClusters() error {
	profile := os.Getenv("AWS_PROFILE")
	region := os.Getenv("AWS_REGION")

	cfg, err := config.LoadDefaultConfig(context.TODO(),
		config.WithSharedConfigProfile(profile),
		config.WithRegion(region),
	)
	if err != nil {
		if strings.Contains(err.Error(), "configured to use SSO but is missing required configuration") {
			return fmt.Errorf("aws profile %q is using SSO but the SDK could not resolve required SSO settings (sso_start_url, sso_region). If this profile uses sso_session, upgrade aws-sdk-go and run 'aws sso login --profile %s': %w", profile, profile, err)
		}

		return fmt.Errorf("failed to create AWS session for profile %q: %w", profile, err)
	}

	svc := eks.NewFromConfig(cfg)

	ctx := context.Background()

	result, err := svc.ListClusters(ctx, &eks.ListClustersInput{})
	if err != nil {
		return fmt.Errorf("failed to list EKS clusters: %w", err)
	}

	fmt.Println(string(utils.Yellow), "\nEKS Test Clusters:", string(utils.Reset))
	utils.clusterArray = nil
	for _, cluster := range result.Clusters {
		accountClusters := []string{"development", "preproduction", "nonlive", "live"}
		if !slices.Contains(accountClusters, cluster) {
			utils.clusterArray = append(utils.clusterArray, cluster)
			fmt.Println(string(utils.Cyan), "Cluster:", string(utils.Reset), cluster)
		}
	}

	return nil
}
