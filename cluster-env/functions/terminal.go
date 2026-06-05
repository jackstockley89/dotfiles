package functions

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"syscall"
)

func SetTerm(clusterName string) {
	fmt.Println(string(utils.Yellow), "Updating Kube Context", string(utils.Reset))
	cmd := exec.Command("aws", "eks", "update-kubeconfig", "--name", clusterName)
	_, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatal(string(utils.Red), "(setTerm): Updating Kube Context: ", err, string(utils.Reset))
	}

	log.Println(string(utils.Yellow), "\nSetting Terminal Context: ", string(utils.Reset))
	cmd = exec.Command("kubectl", "config", "current-context")
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatal(string(utils.Red), "(setTerm)Setting Terminal Context: ", err, string(utils.Reset))
	}

	kconfig := string(out)
	fmt.Println(string(utils.Yellow), "\nSetting Terminal Environment", string(utils.Reset))
	os.Setenv("KUBE_PS1", kconfig+": ")
	errsys := syscall.Exec(os.Getenv("SHELL"), []string{os.Getenv("SHELL")}, os.Environ())
	if errsys != nil {
		log.Fatal(string(utils.Red), "(setTerm)errsys: ", errsys, string(utils.Reset))
	}
}
