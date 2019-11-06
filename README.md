
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

The following is a basic example of using the main function `post_est`. We first start by creating a design matrix from our data and set our paramenters. For detailed information on setting parameters, see Usage vignette.

``` r
library(saferds)
set.seed(700)
## basic example code
XMat <- model.matrix(~ all_data_sim$Week + I(all_data_sim$FY=="FY20"))
Y <- all_data_sim$Rides

mu=matrix(rep(0,ncol(XMat)))
tau2  <- 1
logmu0 <-log(mean(Y))
S=1000
```

We then run and calculate the estimate from the posterior distribution:

``` r
Beta <- post_est(XMat, Y, mu, tau2, logmu0, S, depend=FALSE)
exp(Beta)
#> [1] 1.0191400 0.9970151 1.0080028 1.0028418 0.9187169 0.9580806 0.9774366
#> [8] 0.9870597 0.8399345
```
