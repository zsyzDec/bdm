# normalized dataset

rm(list=ls(all=TRUE))
lib<-"d:\\qjt\\R\\mylibrary"
.libPaths(lib)
library(rpart)
library(class)
library(C50)

fname<-'breast-cancer-wisconsin.data'
bdata<-read.table(fname,sep=',')

# missing value
idx  <-which(bdata$V7!='?')
idx2 <-which(bdata$V7=='?')
bmean<-sum(as.numeric(bdata[idx,'V7']))%/%length(idx)
bdata[idx2,'V7']<-bmean
bdata$V7<-as.numeric(bdata$V7)
bdata<-bdata[,2:11]       # remove V1

bdata.matrix<-as.matrix(bdata)
bdata.matrix.x<-bdata.matrix[,1:9]
bdata.matrix.y<-bdata.matrix[,10]

# scale
bdata.matrix.scale.x<-scale(bdata.matrix.x, center=F, scale=T )

# parameters
size     <- nrow(bdata)
bin      <- size%/%10
start.idx<- 1

acc.cart.default<-0
acc.cart.pruned <-0
acc.c50         <-0
acc.knn         <-0

# ten-fold
folds <- 10
for (k in 0:(folds-1)){
    # browser()
    end.idx    <-if(start.idx+bin>size){size}else{start.idx+bin}
    test.idx   <- start.idx:end.idx
    test       <-bdata.matrix.scale.x[test.idx,]
    test.label <-bdata.matrix.y[test.idx]
    train      <-bdata.matrix.scale.x[-test.idx,]
    train.label<-bdata.matrix.y[-test.idx]
    
    # cart using default value
    ct.train = data.frame(cbind(train,train.label))
    ct.test = data.frame(test)
    ct.defalut <- rpart(train.label~., data=ct.train, method = "class")
    r<-predict(ct.defalut, ct.test, type='class')
    acc.cart.default<-length(which(r==test.label))/length(r)+acc.cart.default
    
    # pruned cart
    ct <- rpart(train.label~.,data=ct.train, method = "class", cp=0.00001, minsplit=1)
    ct.pruned<-prune(ct,ct$cptable[which.min(ct$cptable[,"xerror"]),"CP"])
    r<-predict(ct.pruned, ct.test, type='class')
    acc.cart.pruned<-length(which(r==test.label))/length(r)+acc.cart.pruned
    
    # c5.0
    modle<-C5.0(x=train, y=as.factor(train.label), winnow = F,noGlobalPruning = F,fuzzyThreshold = F)
    res<-predict(modle, test)
    acc.c50<-length(which(res==test.label))/length(res)+acc.c50
    
    # KNN
    nn <- knn(train=train, test=test, cl=train.label, k=5)
    acc.knn<-length(which(nn==test.label))/length(nn) + acc.knn
    
    start.idx <- end.idx+1
    print(k)
}
print(paste("cart.defalut:",acc.cart.default/10, "cart.pruned:",acc.cart.pruned/10, "C50:",acc.c50/10,"KNN:",acc.knn/10))


