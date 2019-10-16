#' Log Likilhood for Poisson Distribution
#'
#' @param XMat Matrix of input data (n-by-m)
#' @param Beta current estimate of posterior distribution
#' @param logmu0 log(mu_0) Log of the mean of Y, used to center the data
#' @param Y Matrix of response data (n-by-1)
#'
#' @return Log Liklihood
LL_pois <- function(XMat, Beta, logmu0, Y){
  return(sum( dpois(Y, exp(logmu0+XMat%*%Beta), log=TRUE)))
}
