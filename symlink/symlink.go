package main

import (
	"bufio"
	"encoding/csv"
	"fmt"
	"io"
	"log"
	"os"
	"strings"

	"github.com/joho/godotenv"
)

// init is invoked before main()
func init() {
	// loads values from .env into the system
	if err := godotenv.Load(); err != nil {
		panic("No .env file found")
	}
}

func main() {
	dotfiles := CheckIfEnvSet("DOTFILES")
	home := CheckIfEnvSet("HOME")

	PopulateSymlink("dotfiles.csv", home, dotfiles)
}

// CheckIfEnvSet checks to see if env var and dir exists
func CheckIfEnvSet(envvar string) string {
	envvar, exists := os.LookupEnv(envvar)
	if !exists {
		panic(envvar + " requried variable does not exist")
	} else if _, err := os.Stat(envvar); os.IsNotExist(err) {
		panic(envvar + " directory does not exist")
	}
	return envvar
}

// CheckIfFileExists checks to see if the csv exists
func CheckIfFileExists(file string) {
	if _, err := os.Stat(file); err != nil {
		panic(file + "doesn't exist")
	}
}

// PopulateSymlink uses a .csv file in the same dir to populate symlinks
func PopulateSymlink(file, home, envvar string) {
	CheckIfFileExists(file)

	csvFile, _ := os.Open(file)
	reader := csv.NewReader(bufio.NewReader(csvFile))

	for {
		line, err := reader.Read()
		if err == io.EOF {
			break
		}
		if err != nil {
			log.Fatal(err)
		}

		target := envvar + "/" + line[0]
		link := home + "/" + strings.TrimSpace(line[1])

		CreateSymlink(target, link)
	}
}

// CreateSymlink creates a new symbolic or "soft" link
func CreateSymlink(target, link string) {
	if _, err := os.Lstat(link); err == nil {
		fmt.Println("Skipping:", link, "already exists")
	} else {
		err := os.Symlink(target, link)
		fmt.Println("Creating:", link)
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
	}
}
