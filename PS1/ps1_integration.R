################# ECON 714 #########################
############### PROBLEM SET 1 ######################
############# INTEGRATION CODE #####################
############# Sergey Sarkisyan #####################
####################################################

## Load required packages
library(tictoc)

## Assign parameter values and function
TT <- 100
rrho <- 0.04
llambda <- 0.02

ufunc <- function(t){
  ufunc <- exp(-rrho*t)*(-exp(-(1 - exp(-llambda*t))))
  return(ufunc)
}

## Set up number of intervals and step
nint <- 10000 
nstep <- (TT-0)/nint

### Midpoint rule
tic.clearlog()
tic()

## Compute summands
summandMidpoint <- rep(0, nint)
for(i in 1:nint){
  summandMidpoint[i] <- ufunc(0 + (i-0.5)*nstep)
}

## Compute integral using midpoint rule
integralMidpoint <- nstep*sum(summandMidpoint)
toc(log = TRUE)


### Trapezoid rule
tic.clearlog()
tic()

## Compute summands
summandTrapezoid <- rep(0, nint)
for(i in 1:nint-1){
  summandTrapezoid[i] <- ufunc(0+i*nstep)
}

## Compute integral
integralTrapezoid <- nstep*(ufunc(0)/2 + sum(summandTrapezoid) + ufunc(TT)/2)
toc(log = TRUE)


### Simpson rule
tic.clearlog()
tic()

## Compute summands and premultiply 2 or 4
summandSimpson <- rep(0, nint)
for(i in 1:nint-1){
  if((i %% 2) == 0){
    summandSimpson[i] <- 2*ufunc(0+i*nstep)
  } else {
    summandSimpson[i] <- 4*ufunc(0+i*nstep)
  }
}

## Compute integral
integralSimpson <- nstep/3*(ufunc(0)+sum(summandSimpson)+ufunc(TT))
toc(log = TRUE)


### Monte Carlo integration
tic.clearlog()
tic()

set.seed(100)
montecarlodraws <- runif(10000, 0, TT)
integralMC <- (TT-0)*mean(ufunc(montecarlodraws))
toc(log = TRUE)












