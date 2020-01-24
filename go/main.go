package main

import (
	"io"
	"net/http"
	"os"
)

func main() {
	installFromWeb("https://github.com/derailed/k9s/releases/download/v0.13.4/k9s_0.13.4_Linux_x86_64.tar.gz", "/usr/local/bin", true)

}

func installFromWeb(url string, dest string, executable bool) (int, error) {
	if err:= DownloadFile
	return 0, nil
}
