################# ECON 714 #########################
############### PROBLEM SET 1 ######################
############# OPTIMIZATION CODE ####################
############# Sergey Sarkisyan #####################
####################################################

## Load required packages
library(tictoc)

## Set up the function, gradient and Hessian
optfunc <- function(x, y){
  optfunc <- 100*(y - x^2)^2 + (1 - x)^2
  return(optfunc)
}

gradientfunc <- function(x, y){
  grad <- c(-100*2*x*(y - x^2)*2 - 2*(1 - x), 100*2*(y - x^2))
  return(grad)
}

hessianfunc <- function(x, y){
  hessian <- matrix(c(-200*2*y + 200*2*3*x^2 + 2, -200*2*x, -200*2*x, 200), 2, 2)
  return(hessian)
}

### Newton-Raphson method
tic.clearlog()
tic()

## Initial value and tolerance
tolerr <- 10^(-4)
vect0 <- c(0, 0)

## Perform optimization
err <- 1
while(err > tolerr){
  vect <- vect0 - solve(hessianfunc(vect0[1],vect0[2])) %*% gradientfunc(vect0[1],vect0[2])
  err <- norm(vect - vect0)
  vect0 <- vect
}
toc(log = TRUE)


### BFGS method
tic.clearlog()
tic()

## Initial value and tolerance
tolerr <- 10^(-4)
vect0 <- c(1.2, 0.8)
hess0 <- hessianfunc(vect0[1],vect0[2])
hessrev0 <- solve(hess0)

## Perform optimization
err <- 1
while(err > tolerr){
  vect <- vect0 - hessrev0 %*% gradientfunc(vect0[1],vect0[2])
  graddiff <- gradientfunc(vect[1],vect[2]) - gradientfunc(vect0[1],vect0[2])
  s <- vect - vect0
  hess <- hess0 + (graddiff %*% t(graddiff))/as.numeric(t(graddiff) %*% s) - (hess0 %*% s %*% t(s) %*% t(hess0))/as.numeric(t(s) %*% hess0 %*% s)
  hessrev <- (diag(2) - (s %*% t(graddiff))/as.numeric(t(graddiff) %*% s)) %*% hessrev0 %*% (diag(2) - (graddiff %*% t(s))/as.numeric(t(graddiff) %*% s)) + (s %*% t(s))/as.numeric(t(graddiff) %*% s) 
  err <- norm(vect - vect0)
  hess0 <- hess
  hessrev0 <- hessrev
  vect0 <- vect
}
toc(log = TRUE)


### Steepest descent method
tic.clearlog()
tic()

## Initial value and tolerance
tolerr <- 10^(-4)
vect0 <- c(1.2, 0.8)

## Perform optimization
err <- 1
d <- c(1, 1)
t0 <- 1
while(err > tolerr & norm(t0*d %*% t(d)) > tolerr){
  d <- -gradientfunc(vect0[1],vect0[2])
  linfun <- function(t){
    opt <- optfunc(vect0[1] + t*d[1], vect0[2] + t*d[2])
    return(opt)
  }
  tval <- seq(0.00001, 0.0001, 0.000001)
  t0 <- tval[which(linfun(tval) == min(linfun(tval)))]
  vect <- vect0 + t0*d
  err <- abs(optfunc(vect[1],vect[2]) - optfunc(vect0[1],vect0[2]))
  vect0 <- vect
}
toc(log = TRUE)


### Conjugate gradient method
tic.clearlog()
tic()

## Initial value and tolerance
tolerr <- 10^(-4)
vect0 <- c(1.2, 0.8)

## Perform optimization
err <- 1
d <- c(1, 1)
t0 <- 1
d0 <- -gradientfunc(vect0[1],vect0[2])
while(err > tolerr & norm(t0*d %*% t(d)) > tolerr){
  linfun <- function(t){
    opt <- optfunc(vect0[1] + t*d[1], vect0[2] + t*d[2])
    return(opt)
  }
  tval <- seq(0.00001, 0.0001, 0.000001)
  t0 <- tval[which(linfun(tval) == min(linfun(tval)))]
  vect <- vect0 + t0*d
  r <- -gradientfunc(vect[1],vect[2])
  beta <- as.numeric(t(r) %*% r)/as.numeric(t(d) %*% d)
  d <- r + beta*d0
  err <- abs(optfunc(vect[1],vect[2]) - optfunc(vect0[1],vect0[2]))
  vect0 <- vect
  d <- d0
}
toc(log = TRUE)











