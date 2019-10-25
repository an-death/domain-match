# Golang domain-match

Example on Golang with benchmarks

```bash
$ go build
$ ./domain-match test@subdomain.domain.spottradingllc.com
    [*.spottradingllc.com]

$ go get github.com/cespare/prettybench
$ go test -bench=. -cpu 1| prettybench
    goos: linux
    goarch: amd64
    pkg: github.com/an-death/domain-match
    PASS
    benchmark                      iter     time/iter
    ---------                      ----     ---------
    BenchmarkDomainMatchBlob/com    100   10.32 ms/op
    BenchmarkDomainMatchBlob/org    100   10.97 ms/op
    
$ GOGC=off go test -bench=. -cpu 1| prettybench
    goos: linux
    goarch: amd64
    pkg: github.com/an-death/domain-match
    PASS
    benchmark                      iter     time/iter
    ---------                      ----     ---------
    BenchmarkDomainMatchBlob/com    100   10.34 ms/op
    BenchmarkDomainMatchBlob/org    126    9.43 ms/op
    ok      github.com/an-death/domain-match        3.251s


```