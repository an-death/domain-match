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
 
  
 $  stack run -- +RTS -A1000M -sstderr
    benchmarking tree_com
    time                 13.35 ms   (12.81 ms .. 13.76 ms)
                         0.992 R²   (0.983 R² .. 0.998 R²)
    mean                 14.75 ms   (14.24 ms .. 16.09 ms)
    std dev              1.792 ms   (724.8 μs .. 2.883 ms)
    variance introduced by outliers: 58% (severely inflated)
    
    benchmarking glob_com
    time                 38.74 ms   (37.62 ms .. 39.78 ms)
                         0.998 R²   (0.996 R² .. 1.000 R²)
    mean                 38.62 ms   (38.25 ms .. 39.07 ms)
    std dev              859.4 μs   (656.1 μs .. 1.080 ms)
    
    benchmarking parser_com
    time                 3.079 ms   (3.007 ms .. 3.151 ms)
                         0.995 R²   (0.992 R² .. 0.998 R²)
    mean                 3.047 ms   (3.003 ms .. 3.104 ms)
    std dev              169.2 μs   (119.5 μs .. 247.7 μs)
    variance introduced by outliers: 37% (moderately inflated)
    
    benchmarking tree_org
    time                 13.60 ms   (13.36 ms .. 13.87 ms)
                         0.998 R²   (0.997 R² .. 1.000 R²)
    mean                 13.44 ms   (13.36 ms .. 13.57 ms)
    std dev              257.7 μs   (183.9 μs .. 348.0 μs)
    
    benchmarking glob_org
    time                 31.28 ms   (30.49 ms .. 32.08 ms)
                         0.997 R²   (0.995 R² .. 0.999 R²)
    mean                 32.10 ms   (31.59 ms .. 32.83 ms)
    std dev              1.297 ms   (822.7 μs .. 1.736 ms)
    variance introduced by outliers: 11% (moderately inflated)
    
    benchmarking parser_org
    time                 1.867 ms   (1.784 ms .. 1.949 ms)
                         0.990 R²   (0.985 R² .. 0.996 R²)
    mean                 1.768 ms   (1.743 ms .. 1.803 ms)
    std dev              103.4 μs   (76.49 μs .. 134.6 μs)
    variance introduced by outliers: 43% (moderately inflated)



```
