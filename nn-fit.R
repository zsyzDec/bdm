# using NN fit a function

rm(list=ls(all=TRUE))
lib<-"d:\\qjt\\R\\mylibrary"
.libPaths(lib)
library(neuralnet)


# generating a sin function
x <- seq(-3, 3, 0.1)
y <- sin(x)
y.noise<-y+rnorm(length(y), 0, 0.1)
data.sin<-data.frame(x=x,y=y.noise)

nn<-neuralnet(y~x, data=data.sin, hidden = c(7,6), threshold = 0.01, stepmax = 1e+05, rep = 1, startweights = NULL, learningrate.limit = NULL, learningrate.factor = list(minus = 0.5, plus = 1.2), learningrate=0.001, lifesign = "none", lifesign.step = 1000, algorithm = "rprop+", err.fct = "sse", act.fct = "logistic", linear.output = TRUE, exclude = NULL, constant.weights = NULL, likelihood = FALSE)

nn.pred<-compute(nn,x)
windows()
ylim <- range(y.noise)
plot(x,y, type="l", col="red", ylim=ylim)
lines(x, nn.pred$net.result, type="l", col="blue")
points(x,y.noise)
