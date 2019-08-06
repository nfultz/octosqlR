# Octosql

This is an R client to interact with the [Octosql](https://github.com/cube2222/octosql) program to query multiple databases.

## Installation

[![CRAN version](http://www.r-pkg.org/badges/version-ago/octosql)](https://cran.r-project.org/package=octosql)

```r
install.packages("octosql")
```

Or you can easily install the most recent development version of the R package as well:

```r
devtools::install_github('nfultz/octosqlR')
```

## What is it good for?

This provides a simplified DBI wrapper around OctoSQL, which provides
a middle layer of metadata, and can thus join across databases for you.


Here is a contrived example, showing all configuration:

``` r

require(DBI)
#> Loading required package: DBI


system("cat ~/octosql.yaml", TRUE)
#>  [1] "dataSources:"                         
#>  [2] "    - name: iris"                     
#>  [3] "      type: csv"                      
#>  [4] "      config:"                        
#>  [5] "          path: /home/nfultz/iris.csv"
#>  [6] "    - name: test"                     
#>  [7] "      type: csv"                      
#>  [8] "      config:"                        
#>  [9] "          path: /home/nfultz/test.csv"
#> [10] ""
system("cat ~/test.csv", TRUE)
#> [1] "a,b,c" "1,2,3" "4,5,6"

conn <- dbConnect(octosql::OctoSQL(), config="~/octosql.yaml")
#> ******************[1] "/home/nfultz/R/x86_64-pc-linux-gnu-library/3.6"
#> [1] "octosql"
#> [1] "octosql-linux"
#> [1] "/home/nfultz/R/x86_64-pc-linux-gnu-library/3.6/octosql/octosql-linux"
#> ******************

dbGetQuery(conn, "select * from test t;")
#>   t.a t.b t.c
#> 1   1   2   3
#> 2   4   5   6
```

<sup>Created on 2019-08-05 by the [reprex package](https://reprex.tidyverse.org) (v0.3.0)</sup>


## What if I want to do other cool things with Octosql and R?

Most database functionality is actually provided by OctoSQL, but if you have R-specific
features in mind, please open a ticket on the feature request, or even better, submit a pull request :)

## It doesn't work here!

