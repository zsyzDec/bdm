# boosted tree

rm(list=ls(all=TRUE))
lib<-"d:\\qjt\\R\\mylibrary"
.libPaths(lib)

# library(data.table)
# library(stringi)
# library(stringr)
# library(magrittr)
library(xgboost)

dat<-read.table('german.data')
label<-dat$V21
gdata<-model.matrix(V21~.-1, data = dat)

acc   <- 0
ind   <- c(1:nrow(gdata))
size  <- nrow(gdata)
step  <- size/10
start <- 1

for(k in c(1:10)){
    end       <- ifelse(start+step>size, size, start+step) 
    testind   <- start:(end-1)
    test      <- gdata[testind,]
    testlabel <- label[testind]
    train     <- gdata[-testind,]
    y         <- label[-testind]==1
    params    <- list(eta=0.4, gamma=10, max_depth=10, early_stopping=50)
    modle     <- xgb.train(data=xgb.DMatrix(train, label=y),
                           verbose = 0, nround = 10000, 
                           objective = "binary:logistic")
    r         <- predict(modle,test)
    r2        <- sapply(r, FUN=function(x){ifelse(x>=0.5,1,2)})
    acc       <- length(which(r2==testlabel))/length(testlabel)+acc
    start     <- end
}
print(acc/10)
