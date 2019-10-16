#' Run the Model
#'
#' @param XMat Matrix of input data (n-by-m)
#' @param Y Matrix of out put data (n-by-1)
#' @param mu Vector of mean used in drawing v (n-by-1)
#' @param tau2 Variance tau^2 used to control variance of the distribution that v is drawn from
#' @param logmu0 log(mu_0) Log of the mean of Y, used to center the data
#' @param S the number of iterations
#' @param depend logicial, is there dependence in the covariance sturcture of the prior distribution?
#' @return The estimated beta (n-by-1 matrix) for my specific model
#' @importFrom MASS mvrnorm
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
  return(list(return_beta, beta_keep))
} #end function
