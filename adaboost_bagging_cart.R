# adaboost VS bagging VS CART

rm(list=ls(all=TRUE))
lib<-"d:\\qjt\\r\\mylibrary"
.libPaths(lib)
library(rpart)
library(adabag)
library(randomForest)

gdata<-read.table('german.data')
gdata$V21<- as.factor(gdata$V21)

acc.cart <- 0
acc.ada  <- 0
acc.bag  <- 0
acc.rf   <- 0
ind      <- c(1:nrow(gdata))
start    <- 1
size     <- floor(nrow(gdata)/10)

for(k in c(1:10)){
    end    <- ifelse(start + size-1>nrow(gdata), nrow(gdata), start+size-1) 
    testind <- start:end
    trainind   <- ind[which(!ind%in%testind)]
    test       <- gdata[testind,]
    test.label <- gdata[testind,'V21']
    train      <- gdata[trainind,]
    
    # random forest
    rf         <- randomForest(V21~., data=train)
    r          <- predict(rf,  newdata=test)
    acc.rf     <- length(which(r ==test.label))/length(test.label)+acc.rf
    
    # adaboost
    ada        <- boosting(V21~., data=train, mfinal=500)
    r          <- predict(ada,  newdata=test)
    acc.ada    <- length(which(r$class==test.label))/length(test.label)+acc.ada
    
    # bagging
    bag        <- bagging(V21~., data=train, mfinal=500)
    r          <- predict(bag,  newdata=test)
    acc.bag    <- length(which(r$class==test.label))/length(test.label)+acc.bag
    
    # CART
    ct        <- rpart(V21 ~ ., data=train, 
                       method = "class", cp=0.00001, minsplit=1)
    ct.pruned <- prune(ct,ct$cptable[which.min(ct$cptable[,"xerror"]),"CP"])
    r         <- predict(ct.pruned, test, type='class')
    acc.cart  <- length(which(r==test.label))/length(r)+acc.cart
    
    start <- end +1
}
print(paste('acc cart:',acc.cart/10, "acc adaboost:",acc.ada/10, "acc bagging:",acc.bag/10, "acc RF:",acc.rf/10))