package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"
	"syscall"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/awserr"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/eks"

	"github.com/TheZoraiz/ascii-image-converter/aic_package"
)

// global variables
var (
	AWSProfile   = "moj-cp"
	clusterName  string
	kubeConfig   string
	clusterArray []string
	home, _      = os.UserHomeDir()
	colourCyan   = "\033[36m"
	colourReset  = "\033[0m"
	colourYellow = "\033[33m"
	colourRed    = "\033[31m"
	// colourGreen  = "\033[32m"
)

// ascii-image-converter
func asciiImage() string {
	// If file is in current directory. This can also be a URL to an image or gif.
	filePath := home + "/Pictures/bot.jpeg"

	flags := aic_package.DefaultFlags()

	// This part is optional.
	// You can directly pass default flags variable to aic_package.Convert() if you wish.
	// There are more flags, but these are the ones shown for demonstration
	flags.Dimensions = []int{50, 25}
	flags.Colored = true
	flags.Braille = true
	flags.Dither = true

	// Note: For environments where a terminal isn't available (such as web servers), you MUST
	// specify atleast one of flags.Width, flags.Height or flags.Dimensions

	// Conversion for an image
	asciiArt, err := aic_package.Convert(filePath, flags)
	if err != nil {
		fmt.Println(err)
	}

	return asciiArt
}

// list eks clusters for aws profile
func listEksClusters() {
	profile := os.Getenv("AWS_PROFILE")
	region := os.Getenv("AWS_REGION")
	awsconfig := os.Getenv("AWS_CONFIG_FILE")
	awscreds := os.Getenv("AWS_SHARED_CREDENTIALS_FILE")

	// Create a session that will use the credentials and config to authenticate
	sess := session.Must(session.NewSessionWithOptions(session.Options{
		Profile:           profile,
		Config:            aws.Config{Region: aws.String(region)},
		SharedConfigState: session.SharedConfigEnable,
		SharedConfigFiles: []string{awsconfig, awscreds},
	}))

	// Create a new instance of the service's client with a Session.
	// Optional aws.Config values can also be provided as variadic arguments
	// to the New function. This option allows you to provide service
	// specific configuration.
	svc := eks.New(sess)

	ctx := context.Background()

	// lists eks clusters
	result, err := svc.ListClustersWithContext(ctx, &eks.ListClustersInput{})
	if err != nil {
		if aerr, ok := err.(awserr.Error); ok {
			switch aerr.Code() {
			default:
				fmt.Println(aerr.Error())
			}
		} else {
			// Print the error, cast err to awserr.Error to get the Code and
			// Message from an error.
			fmt.Println(err.Error())
		}
	}
	fmt.Println(string(colourYellow), "\nEKS Test Clusters:", string(colourReset))
	// exclude live and manager from list
	for _, cluster := range result.Clusters {
		if *cluster != "live" && *cluster != "manager" && *cluster != "live-2" {
			clusterArray = append(clusterArray, *cluster)
			fmt.Println(string(colourCyan), "Cluster:", string(colourReset), *cluster)
		}
	}
}

// setting AWS config
func setAWSEnv(ns string) {
	awsRegion := "eu-west-2"
	awsConfig := home + "/.aws/config"
	awsCreds := home + "/.aws/credentials"
	fmt.Println(string(colourYellow), "\nSetting AWS Configuration", string(colourReset))

	os.Setenv("AWS_PROFILE", ns)
	os.Setenv("AWS_CONFIG_FILE", awsConfig)
	os.Setenv("AWS_SHARED_CREDENTIALS_FILE", awsCreds)
	os.Setenv("AWS_REGION", awsRegion)
	os.Setenv("AWS_DEFAULT_REGION", os.Getenv("AWS_REGION"))

	fmt.Println(string(colourCyan), "AWS_PROFILE:", string(colourReset), os.Getenv("AWS_PROFILE"))
	fmt.Println(string(colourCyan), "AWS_CONFIG_FILE:", string(colourReset), os.Getenv("AWS_CONFIG_FILE"))
	fmt.Println(string(colourCyan), "AWS_SHARED_CREDENTIALS_FILE:", string(colourReset), os.Getenv("AWS_SHARED_CREDENTIALS_FILE"))
	fmt.Println(string(colourCyan), "AWS_REGION:", string(colourReset), os.Getenv("AWS_REGION"))
	fmt.Println(string(colourCyan), "AWS_DEFAULT_REGION:", string(colourReset), os.Getenv("AWS_DEFAULT_REGION"))
}

// sets Kube config
func setKubeEnv(clusterName string) bool {
	var returnOuput bool
	fmt.Println(string(colourYellow), "\nSetting Kube Configuration", string(colourReset))

	if clusterName == "live" {
		kubeConfig = home + "/.kube/" + clusterName + "/config"
		returnOuput = true
	} else if clusterName == "manager" {
		kubeConfig = home + "/.kube/" + clusterName + "/config"
		returnOuput = true
	} else if clusterName == "live-2" {
		kubeConfig = home + "/.kube/" + clusterName + "/config"
		returnOuput = true
	} else if strings.Contains(clusterName, "cp") {
		kubeConfig = home + "/.kube/test/" + clusterName + "/config"
		returnOuput = true
	} else {
		return false
	}

	// these are the three kube variables expected by kubectl
	os.Setenv("KUBECONFIG", kubeConfig)
	// this is needed for kubectl provider
	os.Setenv("KUBE_CONFIG", os.Getenv("KUBECONFIG"))
	os.Setenv("KUBE_CONFIG_PATH", os.Getenv("KUBECONFIG"))

	fmt.Println(string(colourCyan), "KUBECONFIG:", string(colourReset), os.Getenv("KUBECONFIG"))
	fmt.Println(string(colourCyan), "KUBE_CONFIG:", string(colourReset), os.Getenv("KUBE_CONFIG"))
	fmt.Println(string(colourCyan), "KUBE_CONFIG_PATH:", string(colourReset), os.Getenv("KUBE_CONFIG_PATH"))

	return returnOuput
}

// sets Terraform Workspace
func setTFWksp(clusterName string) error {
	// tf workspace to the cluster name
	fmt.Println(string(colourYellow), "\nUpdating Terraform Workspace")
	err := os.Setenv("TF_WORKSPACE", clusterName)
	if err != nil {
		return err
	} else {
		fmt.Println(string(colourCyan), "TF_WORKSPACE:", string(colourReset), os.Getenv("TF_WORKSPACE"))
	}
	return nil
}

func setNamespaceTF(namespace string) {
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

func setTerm(clusterName string) {
	fmt.Println(string(colourYellow), "Updating Kube Context")
	cmd := exec.Command("aws", "eks", "update-kubeconfig", "--name", clusterName)
	cmd.Run()

	log.Println(string(colourYellow), "\nSetting Terminal Context", string(colourReset))
	cmd = exec.Command("kubectl", "config", "current-context")
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatal(string(colourRed), "(setTerm)CombinedOutput: ", err, string(colourReset))
	}

	kconfig := string(out)
	fmt.Println(string(colourYellow), "\nSetting Terminal Environment")
	os.Setenv("KUBE_PS1", kconfig+": ")
	errsys := syscall.Exec(os.Getenv("SHELL"), []string{os.Getenv("SHELL")}, os.Environ())
	if errsys != nil {
		log.Fatal(string(colourRed), "(setTerm)errsys: ", errsys, string(colourReset))
	}
}

func contains(arg string) bool {
	for _, cluster := range clusterArray {
		if cluster == arg {
			return true
		}
	}
	return false
}

// sets up test environment for eks cluster
func testEnv() {
	var arg string

	logo := asciiImage()
	fmt.Printf("\n%v\n", logo)

	setAWSEnv(AWSProfile)
	listEksClusters()
	fmt.Println("Please select a cluster to use:")
	fmt.Scanln(&arg)

	// retry loop with max three attempts
	for i := 0; i < 3; i++ {
		if contains(arg) {
			break
		} else {
			fmt.Println("Please select a cluster from the list:")
			fmt.Scanln(&arg)
		}
	}
	if !contains(arg) {
		log.Fatalf(string(colourRed), "Cluster name is incorrect", string(colourReset))
	}

	clusterName = arg

	b := setKubeEnv(clusterName)
	if !b {
		log.Fatalf(string(colourRed), "Error setting kube config", string(colourReset))
	}

	err := setTFWksp(clusterName)
	if err != nil {
		log.Fatalf(string(colourRed), "Error setting Terraform workspace: %v", err, string(colourReset))
	}

	setTerm(clusterName)
}

func namespaceEnv() {
	var arg string
	var namespaceName string

	logo := asciiImage()
	fmt.Printf("\n%v\n", logo)

	os.Setenv("AWS_PROFILE", AWSProfile)
	clusterArray = []string{"live", "manager", "live-2"}
	fmt.Println("Please enter cluster name:")
	fmt.Scanln(&arg)
	// retry loop with max three attempts
	for i := 0; i < 3; i++ {
		if contains(arg) {
			break
		} else {
			fmt.Println("Please select a cluster from the list:")
			fmt.Scanln(&arg)
		}
	}
	if !contains(arg) {
		log.Fatalf(string(colourRed), "Cluster name is incorrect", string(colourReset))
	}

	clusterName = arg

	fmt.Println("Please enter namespace name:")
	fmt.Scanln(&namespaceName)

	b := setKubeEnv(clusterName)
	if !b {
		log.Fatalf(string(colourRed), "Error setting kube config", string(colourReset))
	}

	os.Setenv("TF_WORKSPACE", clusterName)

	setNamespaceTF(namespaceName)

	setTerm(clusterName)
}

// sets up live environment for eks cluster
func liveManagerEnv(profile string) {
	logo := asciiImage()
	fmt.Printf("\n%v\n", logo)

	setAWSEnv(AWSProfile)
	clusterName = profile

	if clusterName != "live" && clusterName != "manager" && clusterName != "live-2" {
		log.Fatalf(string(colourRed), "Cluster name is incorrect", string(colourReset))
	}

	b := setKubeEnv(clusterName)
	if !b {
		log.Fatalf(string(colourRed), "Error setting kube config", string(colourReset))
	}

	err := setTFWksp(clusterName)
	if err != nil {
		log.Fatalf(string(colourRed), "Error setting Terraform workspace: %v", err, string(colourReset))
	}

	setTerm(clusterName)
}

// passes data from flag to environment variables
// sets a new shell with the updated environment variables
// depending on the flag passed
func main() {
	h, err := os.UserHomeDir()
	if err != nil {
		log.Fatalf("User Home: %v", err)
	}
	arg := flag.String("p", "", "profile for list: live, live-2, manager, test, minikube, namespace")
	profile := arg
	home = h

	flag.Parse()

	// check if profile is live, test, minikube or other
	switch *profile {
	case "live", "manager", "live-2":
		liveManagerEnv(*profile)
	case "test":
		testEnv()
	case "namespace":
		namespaceEnv()
	default:
		log.Fatal(string(colourRed), "Please set a profile from to one of the following:\nlive\nlive-2\nmanager\ntest\nnamespace", string(colourReset))
	}
}
