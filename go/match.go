package main

import (
	"github.com/gobwas/glob"
	jsoniter "github.com/json-iterator/go"
)

var json = jsoniter.ConfigCompatibleWithStandardLibrary

type Template struct {
	Template string `json:"template"`
}

type TPL struct {
	name string
	glob.Glob
}

func parseTemplates(records []Template) []TPL {
	globs := make([]TPL, 0, len(records))
	for _, w := range records {
		g, err := glob.Compile(w.Template)
		if err != nil {
			continue
		}
		globs = append(globs, TPL{w.Template, g})
	}
	return globs
}

func match(patterns []TPL, domain string) []string {
	result := make([]string, 0)
	for _, g := range patterns {
		if !g.Match(domain) {
			continue
		}
		result = append(result, g.name)
	}
	return result
}
