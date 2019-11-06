#' Estimate the Posterior Distribution 
#' 
#' Estimate the Posterior Distribution for the given data using eliptical slice sampling
#'
#' @param XMat Matrix of input data (n-by-m)
#' @param Y Matrix of response data (n-by-1)
#' @param mu Vector of means defined in the prior distribution (n-by-1)
#' @param tau2 Number used to control the Covariance matrix in the prior distribution.
#' @param logmu0 log(mu_0) Log of the mean of Y. Used to center the data
#' @param S the number of iterations
#' @param depend logicial, is there dependence in the covariance sturcture of the prior distribution?
#' @return A list with 
#'   \enumerate{
#'   \item The estimated posterior distribution with the first S/2 esimates burned
#'   \item The estimated standard deviation of the posterior distribution
#'   \item All elements in the last S/2 draws from the posterior distribution. A S/2-by-m matrix where each row is one draw from the posterior distribution.}
#' @importFrom MASS mvrnorm
#' @importFrom stats rnorm
#' @importFrom stats runif
#' @importFrom stats cov2cor
#' @importFrom stats sd
#' @export
post_est <- function(XMat, Y, mu, tau2, logmu0, S, depend =TRUE){
  #need MASS library
  
  p <- ncol(XMat)
  beta <- as.matrix(rep(0,p))
  
  if(depend){
    Sigma <- solve(t(XMat)%*%XMat)
    Sigma <- cov2cor(Sigma)
  }
  
  beta_keep <- matrix(NA,S,p)
  
  for(i in 1:S){
    
    if(depend){v <- as.matrix(mvrnorm(1, mu, Sigma*tau2))}
    else{v <- as.matrix(rnorm(p, 0 , tau2))}
    u <- runif(1,0,1)
    
    a <- LL_pois(XMat, beta, logmu0, Y) + log(u)
    
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
    beta_keep[i,] <- beta
  }#end for
  
  
  return_beta <- colMeans(beta_keep[(S/2+1):S,])
  return_sd <- rep(NA, length(return_beta))
  for(i in 1:length(return_beta)){
    return_sd[i] <- sd(beta_keep[(S/2+1):S,i])
  }
  return(list(return_beta, return_sd, beta_keep[(S/2+1):S,]))
} #end function
