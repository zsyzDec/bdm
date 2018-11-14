# building neural network
rm(list=ls(all=TRUE))
lib<-"d:\\qjt\\R\\mylibrary"
.libPaths(lib)
library(neuralnet)
library(MASS)
data <- Boston

set.seed(100)

index <- sample(1:nrow(data),round(0.75*nrow(data)))
train <- data[index,]
test  <- data[-index,]

# linear regression
lm.fit <- glm(medv~., data=train)
pr.lm <- predict(lm.fit,test)
MSE.lm <- sum((pr.lm - test$medv)^2)/nrow(test)
summary(lm.fit)

# normalized to 0-1
maxs <- apply(data, 2, max) 
mins <- apply(data, 2, min)
scaled <- as.data.frame(scale(data, center = mins, scale = maxs - mins))
train_ <- scaled[index,]
test_ <- scaled[-index,]

# train a neutral network
n <- names(train_)
f <- as.formula(paste("medv ~", paste(n[!n %in% "medv"], collapse = " + ")))
nn <- neuralnet(f,data=train_,hidden=c(5,10),linear.output=T)

# prediction
pr.nn <- compute(nn,test_[,1:13])
pr.nn_ <- pr.nn$net.result*(max(data$medv)-min(data$medv))+min(data$medv)
MSE.nn <- sum((test$medv - pr.nn_)^2)/nrow(test_)
print(paste(MSE.lm,MSE.nn))

# plot
par(mfrow=c(1,2))
plot(test$medv,pr.nn_,col='red',main='Real vs predicted NN',pch=18,cex=0.7)
abline(a=0,b=1,lwd=2)
legend('bottomright',legend='NN',pch=18,col='red', bty='n')

plot(test$medv,pr.lm,col='blue',main='Real vs predicted lm',pch=18, cex=0.7)
abline(0,1,lwd=2)
legend('bottomright',legend='LM',pch=18,col='blue', bty='n', cex=.95)

