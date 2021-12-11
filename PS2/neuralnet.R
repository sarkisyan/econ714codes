#### Traning neural net #############
###### Sergey Sarkisyan #############
########## FNCE 714 #################
#####################################

library(neuralnet)
library(rootSolve)
library(ggplot2)
library(pracma)

# Set parameters
set.seed(134)
kss <- 1.96
knum <- 1000
nlay <- 3
nnodes <- 20
k <- runif(knum, 0.7*kss, 1.3*kss)
kp <- k
Wss <- 1

zz <- c(-0.05, 0, 0.05)
znum <- 3

# Compute labor
ll_1 <- (exp(zz[1])*k^(1/3)/Wss)^3
ll_2 <- (exp(zz[2])*k^(1/3)/Wss)^3
ll_3 <- (exp(zz[3])*k^(1/3)/Wss)^3

# Compute consumption
cc_1 <- exp(zz[1])*k^(1/3)*ll_1^(2/3) - kp + (1 - 0.1)*k
cc_2 <- exp(zz[2])*k^(1/3)*ll_2^(2/3) - kp + (1 - 0.1)*k
cc_3 <- exp(zz[3])*k^(1/3)*ll_3^(2/3) - kp + (1 - 0.1)*k

# Approximate policy functions
policyfunneural_1 <- neuralnet(cc_1~k, hidden = rep(nnodes, nlay), data = data.frame(cc_1, k), act.fct = "tanh")
c1_pred <- predict(policyfunneural_1,data.frame(cc_1, k))

policyfunneural_2 <- neuralnet(cc_2~k, hidden = rep(nnodes, nlay), data = data.frame(cc_2, k), act.fct = "tanh")
c2_pred <- predict(policyfunneural_2,data.frame(cc_2, k))

policyfunneural_3 <- neuralnet(cc_3~k, hidden = rep(nnodes, nlay), data = data.frame(cc_3, k), act.fct = "tanh")
c3_pred <- predict(policyfunneural_3,data.frame(cc_3, k))

cdata <- data.frame(c1_pred, c2_pred, c3_pred, k)
ggplot(cdata, aes(x = k)) + geom_line(aes(y = c1_pred)) + geom_line(aes(y = c2_pred), color = "red") +  geom_line(aes(y = c3_pred), color = "green")

# Compute initial values
value_1 <- (1 - 0.97)*(log(cc_1) - ll_1^2/2)
value_2 <- (1 - 0.97)*(log(cc_2) - ll_2^2/2)
value_3 <- (1 - 0.97)*(log(cc_3) - ll_3^2/2)

# Approximate value functions
valueneural_1 <- neuralnet(value_1~k, hidden = rep(nnodes, nlay), data = data.frame(value_1, k), act.fct = "tanh")
valuepred_1 <- predict(valueneural_1,data.frame(value_1, k))

valueneural_2 <- neuralnet(value_2~k, hidden = rep(nnodes, nlay), data = data.frame(value_2, k), act.fct = "tanh")
valuepred_2 <- predict(valueneural_2,data.frame(value_2, k))

valueneural_3 <- neuralnet(value_3~k, hidden = rep(nnodes, nlay), data = data.frame(value_3, k), act.fct = "tanh")
valuepred_3 <- predict(valueneural_3,data.frame(value_3, k))

valuedata <- data.frame(valuepred_1, valuepred_2, valuepred_3, k)
ggplot(valuedata, aes(x = k)) + geom_line(aes(y = valuepred_1)) + geom_line(aes(y = valuepred_2), color = "red") +  geom_line(aes(y = valuepred_3), color = "green")





