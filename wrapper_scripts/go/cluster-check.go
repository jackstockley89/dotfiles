package main

import (
	"context"
	"fmt"
	"os"
	"os/exec"

	"github.com/hashicorp/terraform-exec/tfexec"
	"k8s.io/client-go/tools/clientcmd"
)

func GetWorkspace() (string, error) {
	// Get the current working directory
	workingDir, err := os.Getwd()
	if err != nil {
		return "", err
	}

	execPath, err := exec.LookPath("terraform")
	if err != nil {
		return "", err
	}

	// Create a new Terraform executor
	executor, err := tfexec.NewTerraform(workingDir, execPath)
	if err != nil {
		return "", err
	}

	// Get the current workspace
	workspace, err := executor.WorkspaceShow(context.Background())
	if err != nil {
		return "", err
	}

	return workspace, nil
}

func GetCurrentContext() (string, error) {
	kubeconfigPath := os.Getenv("KUBECONFIG")
	if kubeconfigPath == "" {
		kubeconfigPath = clientcmd.RecommendedHomeFile
	}

	// Load the kubeconfig file
	config, err := clientcmd.LoadFromFile(kubeconfigPath)
	if err != nil {
		return "", err
	}

	// Get the current context
	currentContext := config.CurrentContext

	if currentContext == "" {
		return "", fmt.Errorf("no current context found in kubeconfig")
	}

	return currentContext, nil
}

func main() {
	workspace, err := GetWorkspace()
	if err != nil {
		fmt.Println("Error:", err)
		os.Exit(1)
	}

	currentContext, err := GetCurrentContext()
	if err != nil {
		fmt.Println("Error:", err)
		os.Exit(1)
	}

	fmt.Printf("Workspace: %s\n", workspace)
	fmt.Printf("Current Context: %s\n", currentContext)

	// compare the workspace and the current context
	// if workspace != currentContext {
	// 	fmt.Printf("Error: The current context %s does not match the Terraform workspace %s\n", currentContext, workspace)
	// 	os.Exit(1)
	// }
}
