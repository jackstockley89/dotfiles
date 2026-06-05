package main

import (
	"flag"
	"log"

	functions "github.com/jackstockley89/dotfiles/cluster-env/functions"
)

var accountProfiles = map[string]struct{}{
	"cp-dev":     {},
	"cp-preprod": {},
	"cp-nonlive": {},
	"cp-live":    {},
}

func isAccountProfile(profile string) bool {
	_, ok := accountProfiles[profile]
	return ok
}

func main() {
	profile := flag.String("p", "", "profile for list: cp-dev, cp-preprod, cp-nonlive, cp-live")
	aws := flag.Bool("aws", false, "list aws clusters")
	flag.Parse()

	validProfile := isAccountProfile(*profile) || *profile == "dev-clusters"
	if !validProfile {
		log.Fatal("Please set a profile from to one of the following:\ncp-dev\ncp-preprod\ncp-nonlive\ncp-live\ndev-clusters")
	}

	if validProfile && !*aws {
		if isAccountProfile(*profile) {
			functions.MPAccountClusters(*profile)
		} else {
			functions.DevelopmentClusters()
		}
		return
	}

	if validProfile && *aws {
		awsProfile := *profile
		if *profile == "dev-clusters" {
			awsProfile = "cp-dev"
		}
		functions.SetAWSEnv(awsProfile)
	}
}
