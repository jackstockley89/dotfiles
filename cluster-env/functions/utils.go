package functions

import (
	"fmt"
	"os"

	"github.com/TheZoraiz/ascii-image-converter/aic_package"
)

type Utils struct {
	Cyan   string
	Reset  string
	Yellow string
	Red    string

	clusterName  string
	kubeConfig   string
	clusterArray []string
	home, _      string
	AWSProfile   string
}

var (
	home, _ = os.UserHomeDir()
	utils   = Utils{
		Cyan:       "\033[36m",
		Reset:      "\033[0m",
		Yellow:     "\033[33m",
		Red:        "\033[31m",
		home:       home,
		AWSProfile: "moj-cp",
	}
)

func AsciiImage() string {
	// If file is in current directory. This can also be a URL to an image or gif.
	filePath := utils.home + "/Pictures/bot.jpeg"

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
