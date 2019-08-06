# Octosql

This is an R client to interact with the [Octosql](https://github.com/cube2222/octosql) program to query multiple databases.

## Installation

[![CRAN version](http://www.r-pkg.org/badges/version-ago/octosql)](https://cran.r-project.org/package=octosql)

```r
install.packages("octosql")
```

Or you can easily install the most recent development version of the R package as well:

```r
devtools::install_github('nfultz/octosql')
```

## What is it good for?

This provides a simplified DBI wrapper around OctoSQL:

```r
require(DBI)
con <- dbConnect(octosql::OctoSQL(), config="foo.yaml")
dbGetQuery(con, "Select count(*) from test")
```


## What if I want to do other cool things with Octosql and R?

Most database functionality is actually provided by OctoSQL, but if you have R-specific
features in mind, please open a ticket on the feature request, or even better, submit a pull request :)

## It doesn't work here!

