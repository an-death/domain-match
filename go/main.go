package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
)

const templatesFile = "templates.json"

func must(err error) {
	if err != nil {
		log.Fatalf("cannot read file %s, err: %T:%s", templatesFile, err, err)
	}
}

func main() {
	checkDomain := os.Args[1]
	f, err := os.Open(templatesFile)
	must(err)

	var templates []Template
	data, _ := ioutil.ReadAll(f)
	must(json.Unmarshal(data, &templates))

	globs := parseTemplates(templates)
	result := match(globs, checkDomain)

	if len(result) > 0 {
		fmt.Printf("%s\n", result)
	} else {
		fmt.Printf("[]\n")
	}
}
