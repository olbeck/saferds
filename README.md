
<!-- README.md is generated from README.Rmd. Please edit that file -->
saferds
=======

<!-- badges: start -->
<!-- badges: end -->
The goal of saferds is to estimate changes in a college safe ride program using bayesian analysis.

Installation
------------

You can install the released version of saferds from [GitHub](https://github.com/Olbeck80920/saferds) with:

``` r
install_github("olbeck80920/saferds")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Olbeck80920/saferds")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
library(saferds)
## basic example code

#Transform data into design matrix: 
XMat <-  model.matrix(~ all_data_sim$Week + all_data_sim$Day +      all_data_sim$Week*all_data_sim$Day)
```

What is special about using `README.Rmd` instead of just `README.md`? You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don't forget to commit and push the resulting figure files, so they display on GitHub!
