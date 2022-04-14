package main

import (
	"context"
	"flag"
	"fmt"
	"os"
	"os/exec"
	"syscall"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/awserr"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/eks"
)

// list eks clusters for aws profile
func listeksclusters() {
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

	// list eks clusters
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
	fmt.Println(result)
}

// passes data from flag to environment variables
// sets a new shell with the updated environment variables
//
func main() {
	colourCyan := "\033[36m"
	colourReset := "\033[0m"
	colourYellow := "\033[33m"

	var env string
	var arg *string
	var arg2 string
	var cxtname string
	profile := []string{"live", "test", "jacksapp"}
	proFlag := flag.String("p", "", "profile name to use for aws. For example: live, test, jacksapp")
	arg = proFlag
	home, _ := os.UserHomeDir()

	// Enable command-line parsing
	flag.Parse()

	for _, p := range profile {
		if *arg == p {
			// set kubeconfig for live or test
			os.Setenv("KUBECONFIG", home+"/.kube/"+p+"/config")
			fmt.Println(string(colourCyan), "KUBECONFIG:", string(colourReset), os.Getenv("KUBECONFIG"))

			// set kube_config_path to kubeconfig
			os.Setenv("KUBE_CONFIG_PATH", os.Getenv("KUBECONFIG"))
			fmt.Println(string(colourCyan), "KUBE_CONFIG_PATH:", string(colourReset), os.Getenv("KUBE_CONFIG_PATH"))

			// set aws_profile to correct profile name
			if p == "jacksapp" {
				fmt.Println("Environment: ")
				fmt.Scanln(&env)
				os.Setenv("AWS_PROFILE", "jacksapp-"+env)
			} else {
				os.Setenv("AWS_PROFILE", "moj-cp")
			}
			fmt.Println(string(colourCyan), "AWS_PROFILE:", string(colourReset), os.Getenv("AWS_PROFILE"))

			// set aws_config_file to correct path
			os.Setenv("AWS_CONFIG_FILE", home+"/.aws/cloud-platform/config")
			fmt.Println(string(colourCyan), "AWS_CONFIG_FILE:", string(colourReset), os.Getenv("AWS_CONFIG_FILE"))

			// set aws_shared_credentials_file to correct path
			os.Setenv("AWS_SHARED_CREDENTIALS_FILE", home+"/.aws/cloud-platform/credentials")
			fmt.Println(string(colourCyan), "AWS_SHARED_CREDENTIALS_FILE:", string(colourReset), os.Getenv("AWS_SHARED_CREDENTIALS_FILE"))

			// set aws_region to correct region
			os.Setenv("AWS_REGION", "eu-west-2")
			fmt.Println(string(colourCyan), "AWS_REGION:", string(colourReset), os.Getenv("AWS_REGION"))

			// set aws_default_region to correct region
			os.Setenv("AWS_DEFAULT_REGION", os.Getenv("AWS_REGION"))
			fmt.Println(string(colourCyan), "AWS_DEFAULT_REGION:", string(colourReset), os.Getenv("AWS_DEFAULT_REGION"))

			if *arg == "test" {
				listeksclusters()
				fmt.Println(string(colourYellow), "Listing EKS Clusters", string(colourReset))
				fmt.Println("Please select a cluster to use")
				fmt.Scanln(&arg2)
				cxtname = arg2
			} else {
				cxtname = *arg
			}
			// update kube config to the new context if profile is test
			if p == "test" {
				// set kubecontext to correct context name
				fmt.Println(string(colourYellow), "Updating Kube Context")
				cmd := exec.Command("aws", "eks", "update-kubeconfig", "--name", cxtname)
				cmd.Run()

				// tf workspace to the cluster name
				fmt.Println(string(colourYellow), "Updating Terraform Workspace")
				os.Setenv("TF_WORKSPACE", cxtname)
				fmt.Println(string(colourCyan), "TF_WORKSPACE:", string(colourReset), os.Getenv("TF_WORKSPACE"))

				// set command line prompt to comtext name
				os.Setenv("PS1", "\\e[1;33m`kubectl config current-context`> \\e[m")
				// start shell with new environment variables
				syscall.Exec(os.Getenv("SHELL"), []string{os.Getenv("SHELL")}, os.Environ())
				return
			} else {
				// set kubecontext to correct context name
				fmt.Println(string(colourYellow), "Updating Kube Context")
				os.Setenv("KUBECONTEXT", cxtname+"."+os.Getenv("CP_ENV"))
				fmt.Println(string(colourCyan), "KUBECONTEXT:", string(colourReset), os.Getenv("KUBECONTEXT"))

				// tf workspace to the cluster name
				fmt.Println(string(colourYellow), "Updating Terraform Workspace")
				os.Setenv("TF_WORKSPACE", cxtname)
				fmt.Println(string(colourCyan), "TF_WORKSPACE:", string(colourReset), os.Getenv("TF_WORKSPACE"))

				// set command line prompt to comtext name
				os.Setenv("PS1", "\\e[1;33m`kubectl config current-context`> \\e[m")
				// start shell with new environment variables
				syscall.Exec(os.Getenv("SHELL"), []string{os.Getenv("SHELL")}, os.Environ())
				return
			}
		}
	}
}
