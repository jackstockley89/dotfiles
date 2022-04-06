package main

import (
	"flag"
	"fmt"
	"os"
	"syscall"
)

func main() {
	var env string
	profile := []string{"live", "test", "jacksapp", "minikube"}
	proFlag := flag.String("p", "live", "profile name to use")
	cxtFlag := flag.String("cxt", "live.cloud-platform.service.justice.gov.uk", "context name to use")
	arg := proFlag
	arg2 := cxtFlag
	home, _ := os.UserHomeDir()

	// Enable command-line parsing
	flag.Parse()

	for _, p := range profile {
		if *arg == p {
			fmt.Println("Profile:", p)
			fmt.Println("Context Name:", *arg2)

			// set kubeconfig for live or test
			os.Setenv("KUBECONFIG", home+"/.kube/"+p+"/config")
			fmt.Println("KUBECONFIG:", os.Getenv("KUBECONFIG"))

			// set kube_config_path to kubeconfig
			os.Setenv("KUBE_CONFIG_PATH", os.Getenv("KUBECONFIG"))
			fmt.Println("KUBE_CONFIG_PATH:", os.Getenv("KUBE_CONFIG_PATH"))

			// set aws_profile to correct profile name
			if p == "live" {
				os.Setenv("AWS_PROFILE", "moj-cp")
			} else if p == "test" {
				os.Setenv("AWS_PROFILE", "moj-cp")
			} else if p == "jacksapp" {
				fmt.Println("Environment: ")
				fmt.Scanln(&env)
				os.Setenv("AWS_PROFILE", "jacksapp-"+env)
			} else {
				os.Setenv("AWS_PROFILE", "")
			}
			fmt.Println("AWS_PROFILE:", os.Getenv("AWS_PROFILE"))

			// set kubecontext to correct context name
			os.Setenv("KUBECONTEXT", *arg2)
			fmt.Println("KUBECONTEXT:", os.Getenv("KUBECONTEXT"))

			// set command line prompt to comtext name
			os.Setenv("PS1", "\\e[1;33m`kubectl config current-context`> \\e[m")

			// set kubectl context to correct context name

			// start shell with new environment variables
			syscall.Exec(os.Getenv("SHELL"), []string{os.Getenv("SHELL")}, os.Environ())
			return
		}
	}
}
