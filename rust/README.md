# Rust domain-match

Example on Rust with benchmarks

```bash

$ cargo +nightly run "test@subdomain.domain.spottradingllc.com"
    *.spottradingllc.com:true

$ cargo +nightly bench  

    test match_glob_com ... bench:   9,963,712 ns/iter (+/- 2,152,450)
    test match_glob_org ... bench:   7,042,154 ns/iter (+/- 1,036,929)

```
