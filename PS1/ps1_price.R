################# ECON 714 #########################
############### PROBLEM SET 1 ######################
############# EQUILIBRIUM PRICE ####################
############# Sergey Sarkisyan #####################
####################################################

## Load required packages
library(tictoc)
library(nloptr)
library(rootSolve)

## Excess demand from FOC for agents
focagent <- function(lambda, price, m, n, oomega, aalpha, endowment){ #lambda is a Lagrange multiplier
  excess <- matrix(rep(0,n*m), n, m)
  for (j in 1:m) {
    for(i in 1:n){
      excess[i,j] <- (lambda[i]*price[j]/aalpha[j])^(1/oomega[j,i]) - endowment[j,i]
    }
  }
  return(excess)
}

## Assign parameters
aalpha3 <- c(1, 1, 1.1) #goods, constant across agents
oomega3 <- matrix(c(0.5, 0.6, 0.3, 
                      0.4, 0.3, 0.5,
                      0.9, 0.2, 0.7), 3, 3) #columns are agents, rows are goods
endowment3 <- matrix(c(1, 2, 0.5,
                       2, 0.7, 1,
                       0.4, 1.5, 3), 3, 3) #columns are agents, rows are goods

## Function of aggregate excess demand
aggrdem <- function(x){
  summand <- focagent(x[1:3], x[4:6], 3, 3, oomega3, aalpha3, endowment3)
  aggr <- rep(0, 3)
  for(j in 1:3){
    aggr[j] <- sum(summand[j,])
  }
  constr <- rep(0, 3)
  for(i in 1:3){
    constr[i] <- x[4:6] %*% summand[,i] - x[4:6] %*% endowment3[,i]
  }
  return(c(aggr^2, constr^2))
}

## Find roots by minimizing sum of squares
p0 <- rep(1, 3) #initial value for price
l0 <- rep(1, 3) #initial value for lambda
local_opts <- list( "algorithm" = "NLOPT_LD_MMA", "xtol_rel" = 1.0e-15 ) #use method of moving asymptotes for local optima
opts <- list( "algorithm" = "NLOPT_GN_ISRES",
              "xtol_rel" = 1.0e-15,
              "maxeval" = 1600000,
              "local_opts" = local_opts,
              "print_level" = 0 ) #use ISRES method for global optima
res <- nloptr( x0 = c(l0, p0),
               eval_f = function(x) sum(aggrdem(x)),
               lb = rep(0,6),
               ub = rep(1000,6),
               opts = opts)

print(res)


ss <- multiroot(f = aggrdem, start = c(l0,p0))


