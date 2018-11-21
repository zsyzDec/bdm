#adaboost VS CART

rm(list=ls(all=TRUE))
lib<-"d:\\qjt\\r\\mylibrary"
.libPaths(lib)
library(fastAdaboost)
library(rpart)

gdata<-read.table('german.data')
gdata$V21<- as.factor(gdata$V21)
# marital<-sapply(gdata$V9, function(x) switch(x,
#                                              A91="m",
#                                              A92="m",
#                                              A93="s",
#                                              A94="m",
#                                              A95="s",
#                                              "null"))
# gdata$marital<-as.factor(marital)

acc.cart <- 0
acc.ada  <- 0
ind      <- c(1:nrow(gdata))

for(k in c(1:10)){
    testind    <- c((k*100-100+1):(k*100))
    trainind   <- ind[which(!ind%in%testind)]
    test       <- gdata[testind,]
    test.label <- gdata[testind,'V21']
    train      <- gdata[trainind,]
    modle      <- adaboost(V21~.,data=train, nIter=10)
    r          <- predict(modle,  newdata=test)
    acc.ada    <- length(which(r$class==test.label))/length(test.label)+acc.ada
    
    # CART
    ct        <- rpart(V21 ~ ., data=train, 
                       method = "class", cp=0.00001, minsplit=1)
    ct.pruned <- prune(ct,ct$cptable[which.min(ct$cptable[,"xerror"]),"CP"])
    r         <- predict(ct.pruned, test, type='class')
    acc.cart  <- length(which(r==test.label))/length(r)+acc.cart
}
print(paste('acc cart:',acc.cart/10, "acc adaboost:",acc.ada/10))