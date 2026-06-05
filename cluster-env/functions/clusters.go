package functions

import (
	"fmt"
	"log"
	"slices"
)

func DevelopmentClusters() {
	var arg string

	logo := AsciiImage()
	fmt.Printf("\n%v\n", logo)

	SetAWSEnv("cp-dev")
	err := ListEksClusters()
	if err != nil {
		log.Fatalf(string(utils.Red), "Error listing EKS clusters: %v", err, string(utils.Reset))
	}
	fmt.Println("Please select a cluster to use:")
	fmt.Scanln(&arg)

	for range 3 {
		if slices.Contains(utils.clusterArray, arg) {
			break
		} else {
			fmt.Println("Please select a cluster from the list:")
			fmt.Scanln(&arg)
		}
	}
	if !slices.Contains(utils.clusterArray, arg) {
		log.Fatalf(string(utils.Red), "Cluster name is incorrect", string(utils.Reset))
	}

	utils.clusterName = arg

	b := SetKubeEnv("", utils.clusterName)
	if !b {
		log.Fatalf(string(utils.Red), "Error setting kube config", string(utils.Reset))
	}

	err = SetTFWksp(utils.clusterName)
	if err != nil {
		log.Fatalf(string(utils.Red), "Error setting Terraform workspace: %v", err, string(utils.Reset))
	}

	SetTerm(utils.clusterName)
}

func MPAccountClusters(profile string) {
	logo := AsciiImage()
	fmt.Printf("\n%v\n", logo)

	SetAWSEnv(profile)
	switch profile {
	case "cp-dev":
		utils.clusterName = "development"
	case "cp-preprod":
		utils.clusterName = "preproduction"
	case "cp-nonlive":
		utils.clusterName = "nonlive"
	case "cp-live":
		utils.clusterName = "live"
	default:
		log.Fatalf(string(utils.Red), "Cluster name is incorrect", string(utils.Reset))
	}

	b := SetKubeEnv(profile, utils.clusterName)
	if !b {
		log.Fatalf(string(utils.Red), "Error setting kube config", string(utils.Reset))
	}

	err := SetTFWksp("cloud-platform-" + utils.clusterName)
	if err != nil {
		log.Fatalf(string(utils.Red), "Error setting Terraform workspace: %v", err, string(utils.Reset))
	}

	SetTerm(utils.clusterName)
}
