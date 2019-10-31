#' Elipitical Slice Sampler
#'
#' @param XMat Matrix of input data (n-by-m)
#' @param Y Matrix of out put data (n-by-1)
#' @param Sigma corrolation matrix of the prior distribution
#' @param beta current estimate of posterior distrubution
#' @param mu Vector of mean used in drawing v (n-by-1)
#' @param tau2 Variance tau^2 used to control variance of the distribution that v is drawn from
#' @param logmu0 log(mu_0) Log of the mean of Y, used to center the data
#' @param depend logicial, is there dependence in the covariance sturcture of the prior distribution?
#' @return The estimated beta (n-by-1 matrix)
#' @importFrom MASS mvrnorm
ess <-function(XMat, Y, Sigma, beta, mu, tau2, logmu0, depend = TRUE) {
  
  p <- ncol(XMat)
  
  if(depend){v = as.matrix(mvrnorm(1, mu, Sigma*tau2))}
  else{v <- as.matrix(rnorm(p, 0 , tau2))}
  
  u <- runif(1,0,1)
  
  a <- LL_pois(beta, logmu0, Y, XMat) + log(u)
  
  Need_New_Window<-TRUE
  theta <- runif(1,0,2*pi)
  theta_min <- theta - 2*pi
  theta_max <- theta
  
  while(Need_New_Window){
    BetaPrime <- beta*cos(theta) + v*sin(theta)
    if(LL_pois(XMat, BetaPrime, logmu0, Y) > a){
      beta <- BetaPrime
      Need_New_Window <- FALSE
    }#end if
    else{
      if(theta<0){theta_min<-theta}
      else{theta_max<-theta}
      theta <- runif(1, theta_min, theta_max)
    }#end else
  }#end while
  
  return(beta)
  
}
