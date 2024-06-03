
<!-- README.md is generated from README.Rmd. Please edit that file -->

# zenstats

<!-- badges: start -->

[![R-CMD-check](https://github.com/rfsaldanha/zenstats/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rfsaldanha/zenstats/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

A Zenodo deposit contains some statistics of interest, like the number
of views and downloads, that is not available to programmaticaly access
through its API. The `zenstats` package scraps deposit webpages and
return the deposits statistics as a tibble.

## Installation

You can install the stable release from CRAN.

``` r
install.packages("zenstats")
library(zenstats)
```

Or install the development version of from GitHub:

``` r
# install.packages("remotes")
remotes::install_github("rfsaldanha/zenstats")
library(zenstats)
```

## Example

``` r
library(zenstats)

ids <- c(10036212, 10947952)

deposit_stats(ids, all_versions_only = TRUE, progress = FALSE)
#> # A tibble: 2 × 5
#>   date                 deposit views downloads  volume
#>   <dttm>                 <dbl> <dbl>     <dbl>   <byt>
#> 1 2024-06-03 09:51:25 10036212   564       344 1.50 TB
#> 2 2024-06-03 09:51:36 10947952    94        44 1.90 GB
```

## Polite webpage crawling

This package respects the ‘robots.txt’ policies from Zenodo, including
the crawl delay of 10 seconds.
