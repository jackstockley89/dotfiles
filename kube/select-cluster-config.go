package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"os"
	"os/exec"
	"syscall"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/awserr"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/eks"
)

// global variables
var (
	awsProfile *string

	ns      string
	env     string
	cxtname string
	home    string

	colourCyan   = "\033[36m"
	colourReset  = "\033[0m"
	colourYellow = "\033[33m"
	colourRed    = "\033[31m"
)

// list eks clusters for aws profile
func ListEksClusters() {
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
	// exclude live and manager from list
	for _, cluster := range result.Clusters {
		if *cluster != "live" && *cluster != "manager" {
			fmt.Println(string(colourYellow), "\nEKS Test Clusters", string(colourReset))
			fmt.Println(string(colourCyan), "Cluster Name:", string(colourReset), *cluster)
		}
	}
}

//setting AWS config
func SetAWSEnv() {
	awsRegion := "eu-west-2"
	awsConfig := home + "/.aws/cloud-platform/config"
	awsCreds := home + "/.aws/cloud-platform/credentials"
	fmt.Println(string(colourYellow), "\nSetting AWS Configuration", string(colourReset))
	// set aws_config_file to correct path
	// set aws_shared_credentials_file to correct path
	// set aws_region to correct region
	// set aws_default_region to correct region
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
func SetKubeEnv() {
	fmt.Println(string(colourYellow), "\nSetting Kube Configuration", string(colourReset))
	// set kubeconfig for live or test
	// set kube_config_path to kubeconfig
	if *awsProfile == "namespace" {
		kubeConfig := home + "/.kube/" + ns + "/config"
		os.Setenv("KUBECONFIG", kubeConfig)
		os.Setenv("KUBE_CONFIG_PATH", os.Getenv("KUBECONFIG"))
	} else {
		kubeConfig := home + "/.kube/" + *awsProfile + "/config"
		os.Setenv("KUBECONFIG", kubeConfig)
		os.Setenv("KUBE_CONFIG_PATH", os.Getenv("KUBECONFIG"))

	}

	fmt.Println(string(colourCyan), "KUBECONFIG:", string(colourReset), os.Getenv("KUBECONFIG"))
	fmt.Println(string(colourCyan), "KUBE_CONFIG_PATH:", string(colourReset), os.Getenv("KUBE_CONFIG_PATH"))
}

// sets Terraform Workspace
func SetTFWksp(cxtname string) {
	// tf workspace to the cluster name
	fmt.Println(string(colourYellow), "\nUpdating Terraform Workspace")
	os.Setenv("TF_WORKSPACE", cxtname)

	fmt.Println(string(colourCyan), "TF_WORKSPACE:", string(colourReset), os.Getenv("TF_WORKSPACE"))
}

// creating terminal
func SetTerm() {
	// set command line prompt to comtext name
	os.Setenv("KUBE_PS1", "\\e[1;33m`kubectl config current-context`> \\e[m")
	// start shell with new environment variables
	syscall.Exec(os.Getenv("SHELL"), []string{os.Getenv("SHELL")}, os.Environ())
}

// sets up test environment for eks cluster
func TestEnv() {
	var arg string
	SetKubeEnv()
	os.Setenv("AWS_PROFILE", "moj-cp")
	SetAWSEnv()
	ListEksClusters()
	fmt.Println("Please select a cluster to use:")
	fmt.Scanln(&arg)
	cxtname := arg
	// set kubecontext to correct context name
	fmt.Println(string(colourYellow), "Updating Kube Context")
	cmd := exec.Command("aws", "eks", "update-kubeconfig", "--name", cxtname, "--region", "eu-west-2")
	cmd.Run()
	// Set Terraform workspace to the cluster name
	SetTFWksp(cxtname)
	SetTerm()
}

// sets up live environment for eks cluster
func LiveEnv() {
	SetKubeEnv()
	os.Setenv("AWS_PROFILE", "moj-cp")
	SetAWSEnv()
	cxtname = *awsProfile
	// set kubecontext to correct context name
	fmt.Println(string(colourYellow), "Updating Kube Context")
	os.Setenv("KUBECONTEXT", cxtname+"."+os.Getenv("CP_ENV"))
	fmt.Println(string(colourCyan), "KUBECONTEXT:", string(colourReset), os.Getenv("KUBECONTEXT"))
	// Set Terraform workspace to the cluster name
	SetTFWksp(cxtname)
	SetTerm()
}

//sets up minikube environment for eks cluster
func MinikubeEnv() {
	SetKubeEnv()
	cxtname = *awsProfile
	// set kubecontext to correct context name
	fmt.Println(string(colourYellow), "Updating Kube Context")
	os.Setenv("KUBECONTEXT", cxtname)
	fmt.Println(string(colourCyan), "KUBECONTEXT:", string(colourReset), os.Getenv("KUBECONTEXT"))
	// start minikube
	fmt.Println(string(colourYellow), "Starting Minikube")
	cmd := exec.Command("minikube", "start")
	cmd.Run()
	SetTerm()
}

// sets up namespace environment for eks cluster
func NamespaceEnv() {
	fmt.Println("Namespace: ")
	fmt.Scanln(&ns)
	fmt.Println("Environment: ")
	fmt.Scanln(&env)
	SetKubeEnv()
	os.Setenv("AWS_PROFILE", ns+"-"+env)
	SetAWSEnv()
	cxtname = "live"
	// set kubecontext to correct context name
	fmt.Println(string(colourYellow), "Updating Kube Context")
	os.Setenv("KUBECONTEXT", cxtname+"."+os.Getenv("CP_ENV"))
	fmt.Println(string(colourCyan), "KUBECONTEXT:", string(colourReset), os.Getenv("KUBECONTEXT"))
	// Set Terraform workspace to the cluster name
	SetTFWksp(cxtname)
	SetTerm()
}

// passes data from flag to environment variables
// sets a new shell with the updated environment variables
// depending on the flag passed
func main() {
	h, err := os.UserHomeDir()
	if err != nil {
		log.Fatal(err)
	}
	arg := flag.String("p", "", "profile name list: live, test, minikube, namespace")
	awsProfile = arg
	home = h

	flag.Parse()

	// check if profile is live, test, minikube or other
	if *awsProfile == "live" {
		LiveEnv()
	} else if *awsProfile == "test" {
		TestEnv()
	} else if *awsProfile == "minikube" {
		MinikubeEnv()
	} else if *awsProfile == "namespace" {
		NamespaceEnv()
	} else {
		fmt.Println(string(colourRed), "Please set a profile name to one of the following: live, test, minikube, namespace", string(colourReset))
		os.Exit(1)
	}
}
