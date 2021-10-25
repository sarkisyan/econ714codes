################# ECON 714 #########################
############### PROBLEM SET 1 ######################
############## PARETO WEIGHTS ######################
############# Sergey Sarkisyan #####################
####################################################

## Load required packages
library(tictoc)
library(nloptr)

## Utility function
socialplanner <- function(x, m, n, llambda, oomega, aalpha, endowment){
  optu <- matrix(rep(0, m*n), m, n)
  sumx <- sum(x) - x[m,n]
  for (i in 1:n) {
    for (j in 1:m) {
      optu[j, i] <- -llambda[i]*aalpha[j]*x[j,i]^(1 + oomega[j,i])/(1 + oomega[j,i])
    }
  }
   optimalfunc <- sum(optu)
  return(as.vector(optimalfunc))
}

## Gradient
gradsocialplanner <- function(x, m, n, llambda, oomega, aalpha, endowment){
  grad <- matrix(rep(0, m*n), m, n)
  sumx <- sum(x) - x[m,n]
  for (i in 1:n) {
    for (j in 1:m) {
      grad[j,i] <- llambda[i]*aalpha[j]*x[j,i]^oomega[j,i]
    }
  }
  return(as.vector(grad))
}


### Case without heterogeneity
tic.clearlog()
tic()

## Assign parameters
aalpha3eq <- c(1, 1, 1) #goods, constant across agents
llambda3eq <- c(1/3, 1/3, 1 - 1/3 - 1/3) #pareto weights
oomega3eq <- matrix(c(0.5, 0.6, 0.7, 
                   0.5, 0.6, 0.7,
                   0.5, 0.6, 0.7), 3, 3) #columns are agents, rows are goods
endowment3 <- matrix(c(1, 2, 0.5,
                      2, 0.7, 1,
                      0.4, 1.5, 3), 3, 3) #columns are agents, rows are goods

## Optimize using NLOPT
x0 <- rep(sum(endowment3)/9,9) #initial value
local_opts <- list( "algorithm" = "NLOPT_LD_MMA", "xtol_rel" = 1.0e-15 ) #use method of moving asymptotes for local optima
opts <- list( "algorithm" = "NLOPT_GN_ISRES",
              "xtol_rel" = 1.0e-15,
              "maxeval" = 160000,
              "local_opts" = local_opts,
              "print_level" = 0 ) #use ISRES method for global optima
res <- nloptr( x0 = x0,
               eval_f = function(x) -socialplanner(matrix(x, 3, 3),3,3,llambda3eq,oomega3eq,aalpha3eq,endowment3),
               lb = rep(0,9),
               ub = rep(5,9),
               eval_g_eq = function(x) sum(x) - 1,
               opts = opts)

print(res)

toc(log = TRUE)


### Case with heterogeneity
tic.clearlog()
tic()

## Assign parameters
aalpha3ineq <- c(0.8, 1, 1.2) #goods, constant across agents
llambda3ineq <- c(1/3, 1/2, 1 - 1/2 - 1/3) #pareto weights
oomega3ineq <- matrix(c(0.5, 0.2, 0.9, 
                      0.3, 0.5, 0.3,
                      0.6, 0.3, 0.4), 3, 3) #columns are agents, rows are goods
endowment3 <- matrix(c(1, 2, 0.5,
                       2, 0.7, 1,
                       0.4, 1.5, 3), 3, 3) #columns are agents, rows are goods

## Optimize using NLOPT
x0 <- rep(sum(endowment3)/9,9) #initial value
local_opts <- list( "algorithm" = "NLOPT_LD_MMA", "xtol_rel" = 1.0e-15 ) #use method of moving asymptotes for local optima
opts <- list( "algorithm" = "NLOPT_GN_ISRES",
              "xtol_rel" = 1.0e-15,
              "maxeval" = 160000,
              "local_opts" = local_opts,
              "print_level" = 0 ) #use ISRES method for global optima
res <- nloptr( x0 = x0,
               eval_f = function(x) -socialplanner(matrix(x, 3, 3),3,3,llambda3ineq,oomega3ineq,aalpha3ineq,endowment3),
               lb = rep(0,9),
               ub = rep(5,9),
               eval_g_eq = function(x) sum(x) - 1,
               opts = opts)

print(res)

toc(log = TRUE)

### Case with m=n=10
tic.clearlog()
tic()

## Assign parameters
aalpha10eq <- rep(1, 10) #goods, constant across agents
llambda10eq <- rep(1/3, 10) #pareto weights
oomega10eq <- matrix(c(0.5, 0.6, 0.7, 0.4, 0.8, 0.3, 0.6, 0.5, 0.2, 0.5,
                       0.5, 0.6, 0.7, 0.4, 0.8, 0.3, 0.6, 0.5, 0.2, 0.5,
                       0.5, 0.6, 0.7, 0.4, 0.8, 0.3, 0.6, 0.5, 0.2, 0.5,
                       0.5, 0.6, 0.7, 0.4, 0.8, 0.3, 0.6, 0.5, 0.2, 0.5,
                       0.5, 0.6, 0.7, 0.4, 0.8, 0.3, 0.6, 0.5, 0.2, 0.5,
                       0.5, 0.6, 0.7, 0.4, 0.8, 0.3, 0.6, 0.5, 0.2, 0.5,
                       0.5, 0.6, 0.7, 0.4, 0.8, 0.3, 0.6, 0.5, 0.2, 0.5,
                       0.5, 0.6, 0.7, 0.4, 0.8, 0.3, 0.6, 0.5, 0.2, 0.5,
                       0.5, 0.6, 0.7, 0.4, 0.8, 0.3, 0.6, 0.5, 0.2, 0.5,
                       0.5, 0.6, 0.7, 0.4, 0.8, 0.3, 0.6, 0.5, 0.2, 0.5), 10, 10) #columns are agents, rows are goods
endowment10 <- matrix(runif(100, 0.3, 1.2), 10, 10) #columns are agents, rows are goods

## Optimize using NLOPT
x0 <- rep(sum(endowment10)/100,100) #initial value
local_opts <- list( "algorithm" = "NLOPT_LD_MMA", "xtol_rel" = 1.0e-15 ) #use method of moving asymptotes for local optima
opts <- list( "algorithm"= "NLOPT_GN_ISRES",
              "xtol_rel"= 1.0e-15,
              "maxeval"= 160000,
              "local_opts" = local_opts,
              "print_level" = 0 ) #use ISRES method for global optima
res <- nloptr( x0 = x0,
               eval_f = function(x) -socialplanner(matrix(x, 10, 10),10,10,llambda10eq,oomega10eq,aalpha10eq,endowment10),
               lb = rep(0,100),
               ub = rep(5,100),
               eval_g_eq = function(x) sum(x) - 1,
               opts = opts)

print(res)

toc(log = TRUE)










