package main

import (
	"io/ioutil"
	"os"
	"testing"
)

func bMust(b *testing.B, err error) {
	if err != nil {
		b.Fatal(err)
	}
}

func BenchmarkDomainMatchBlob(b *testing.B) {
	f, err := os.Open(templatesFile)
	bMust(b, err)

	var templates []Template
	data, _ := ioutil.ReadAll(f)
	bMust(b, json.Unmarshal(data, &templates))

	var testCases = []struct {
		name     string
		email    string
		expected string
	}{
		{"com", "test@subdomain.domain.spottradingllc.com", "*.spottradingllc.com"},
		{"org", "test@domain.nyumc.org", "*.nyumc.org"},
	}
	for _, tc := range testCases {
		b.ResetTimer()
		b.Run(tc.name, func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				tpls := parseTemplates(templates)
				matched := match(tpls, tc.email)

				if len(matched) == 0 || matched[0] != tc.expected {
					b.Fatalf("fail match %s", tc.email)
				}
			}
		})
	}
}
