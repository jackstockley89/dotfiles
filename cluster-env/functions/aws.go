package functions

import (
	"fmt"
	"os"
)

func SetAWSEnv(profile string) {
	awsRegion := "eu-west-2"
	awsConfig := home + "/.aws/config"
	awsCreds := home + "/.aws/credentials"
	fmt.Println(string(utils.Yellow), "\nSetting AWS Configuration", string(utils.Reset))

	os.Setenv("AWS_PROFILE", profile)
	os.Setenv("AWS_CONFIG_FILE", awsConfig)
	os.Setenv("AWS_SHARED_CREDENTIALS_FILE", awsCreds)
	os.Setenv("AWS_REGION", awsRegion)
	os.Setenv("AWS_DEFAULT_REGION", os.Getenv("AWS_REGION"))

	fmt.Println(string(utils.Cyan), "AWS_PROFILE:", string(utils.Reset), os.Getenv("AWS_PROFILE"))
	fmt.Println(string(utils.Cyan), "AWS_CONFIG_FILE:", string(utils.Reset), os.Getenv("AWS_CONFIG_FILE"))
	fmt.Println(string(utils.Cyan), "AWS_SHARED_CREDENTIALS_FILE:", string(utils.Reset), os.Getenv("AWS_SHARED_CREDENTIALS_FILE"))
	fmt.Println(string(utils.Cyan), "AWS_REGION:", string(utils.Reset), os.Getenv("AWS_REGION"))
	fmt.Println(string(utils.Cyan), "AWS_DEFAULT_REGION:", string(utils.Reset), os.Getenv("AWS_DEFAULT_REGION"))
}
