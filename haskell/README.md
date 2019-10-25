# Haskell domain-match

Haskell have a 3 realization:

- Based on `Glob` library
- Based on `Attoparsec` library
- Based on Tree

```bash

$ stack run
    benchmarking tree_com
        time                 19.80 ms   (19.22 ms .. 20.62 ms)
                             0.995 R²   (0.990 R² .. 0.999 R²)
        mean                 19.23 ms   (19.03 ms .. 19.60 ms)
        std dev              639.5 μs   (371.4 μs .. 937.2 μs)
        
    benchmarking glob_com
        time                 50.81 ms   (49.96 ms .. 51.73 ms)
                             0.999 R²   (0.997 R² .. 1.000 R²)
        mean                 50.75 ms   (50.09 ms .. 51.78 ms)
        std dev              1.576 ms   (862.6 μs .. 2.702 ms)
        
    benchmarking parser_com
        time                 15.85 ms   (15.49 ms .. 16.32 ms)
                             0.996 R²   (0.991 R² .. 0.999 R²)
        mean                 15.21 ms   (14.95 ms .. 15.50 ms)
        std dev              655.5 μs   (492.5 μs .. 920.3 μs)
        variance introduced by outliers: 16% (moderately inflated)
        
    benchmarking tree_org
        time                 18.68 ms   (18.35 ms .. 18.99 ms)
                             0.999 R²   (0.997 R² .. 0.999 R²)
        mean                 19.23 ms   (18.98 ms .. 19.61 ms)
        std dev              717.8 μs   (405.1 μs .. 1.194 ms)
        variance introduced by outliers: 13% (moderately inflated)
    
    benchmarking glob_org
        time                 41.81 ms   (40.83 ms .. 42.66 ms)
                             0.999 R²   (0.997 R² .. 1.000 R²)
        mean                 42.88 ms   (42.35 ms .. 43.52 ms)
        std dev              1.181 ms   (918.4 μs .. 1.499 ms)
    
    benchmarking parser_org
        time                 10.96 ms   (10.75 ms .. 11.18 ms)
                             0.998 R²   (0.996 R² .. 0.999 R²)
        mean                 11.02 ms   (10.85 ms .. 11.25 ms)
        std dev              525.1 μs   (368.8 μs .. 758.1 μs)
        variance introduced by outliers: 20% (moderately inflated)
 

 $ stack run -- +RTS -A100M
    benchmarking tree_com
        time                 14.26 ms   (13.89 ms .. 14.94 ms)
                             0.993 R²   (0.983 R² .. 0.999 R²)
        mean                 14.13 ms   (13.91 ms .. 14.46 ms)
        std dev              646.4 μs   (469.3 μs .. 974.4 μs)
        variance introduced by outliers: 19% (moderately inflated)
    
    benchmarking glob_com
        time                 38.56 ms   (36.26 ms .. 39.64 ms)
                             0.993 R²   (0.980 R² .. 1.000 R²)
        mean                 41.40 ms   (40.32 ms .. 43.50 ms)
        std dev              2.989 ms   (1.547 ms .. 4.785 ms)
        variance introduced by outliers: 25% (moderately inflated)

    benchmarking parser_com
        time                 3.263 ms   (3.193 ms .. 3.337 ms)
                             0.993 R²   (0.987 R² .. 0.998 R²)
        mean                 3.254 ms   (3.206 ms .. 3.323 ms)
        std dev              188.7 μs   (144.6 μs .. 251.8 μs)
        variance introduced by outliers: 38% (moderately inflated)
    
    benchmarking tree_org
        time                 13.98 ms   (13.50 ms .. 14.55 ms)
                             0.994 R²   (0.988 R² .. 0.998 R²)
        mean                 13.85 ms   (13.66 ms .. 14.16 ms)
        std dev              567.6 μs   (377.0 μs .. 786.2 μs)
        variance introduced by outliers: 15% (moderately inflated)

    benchmarking glob_org
        time                 31.42 ms   (30.86 ms .. 31.83 ms)
                             0.999 R²   (0.997 R² .. 1.000 R²)
        mean                 31.39 ms   (31.08 ms .. 32.01 ms)
        std dev              903.2 μs   (522.1 μs .. 1.511 ms)

    benchmarking parser_org
        time                 1.910 ms   (1.876 ms .. 1.958 ms)
                             0.995 R²   (0.991 R² .. 0.998 R²)
        mean                 1.931 ms   (1.895 ms .. 1.965 ms)
        std dev              112.7 μs   (85.37 μs .. 152.7 μs)
        variance introduced by outliers: 43% (moderately inflated)

```
