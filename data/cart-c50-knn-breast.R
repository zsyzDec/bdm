# cart, C5.0, KNN 10-fold cross validation on wisconsion breast canser dataset

rm(list=ls(all=TRUE))
lib<-"d:\\qjt\\R\\mylibrary"
.libPaths(lib)
library(rpart)
library(class)

fname<-'breast-cancer-wisconsin.data'
bdata<-read.table(fname,sep=',')

# missing value
idx<-which(bdata$V7!='?')
idx2<-which(bdata$V7=='?')
bmean<-sum(as.numeric(bdata[idx,'V7']))%/%length(idx)
bdata[idx2,'V7']<-bmean
bdata$V7<-as.numeric(bdata$V7)

# parameters
size<-nrow(bdata)
bin<-size%/%10
start_idx<-1

acc_cart_default<-0
acc_cart_pruned <-0
acc_c50         <-0
acc_knn         <-0

# ten-fold
folds <- 10
for (k in 0:(folds-1)){
    # browser()
    end_idx<-if(start_idx+bin>size){size}else{start_idx+bin}
    test_idx <- start_idx:end_idx
    test<-bdata[test_idx,1:10]
    test_label<-bdata[test_idx,11]
    train<-bdata[-test_idx,]
    
    # cart using default value
    ct.defalut <- rpart(V11 ~ ., data=train, method = "class")
    r<-predict(ct.defalut, test, type='class')
    acc_cart_default<-length(which(r==test_label))/length(r)+acc_cart_default

    # pruned cart
    ct <- rpart(V11 ~ ., data=train, method = "class", cp=0.00001, minsplit=1)
    ct.pruned<-prune(ct,ct$cptable[which.min(ct$cptable[,"xerror"]),"CP"])
    r<-predict(ct.pruned, test, type='class')
    acc_cart_pruned<-length(which(r==test_label))/length(r)+acc_cart_pruned
    
    # c5.0
    train_c50<-train
    train_c50$V11<-as.factor(train$V11)
    modle<-C5.0(V11 ~.,data=train_c50, winnow = F,noGlobalPruning = F,fuzzyThreshold = F)
    res<-predict(modle, test)
    acc_c50<-length(which(res==test_label))/length(res)+acc_c50
    
    # KNN
    train_knn <- train[,1:10]
    train_knn_label <- train[,11]
    nn <- knn(train=train_knn, test=test, cl=train_knn_label, k=5)
    acc_knn<-length(which(nn==test_label))/length(nn) + acc_knn
    
    start_idx<-end_idx+1
    print(k)
}
print(paste("cart_defalut:",acc_cart_default/10, "cart_pruned:",acc_cart_pruned/10, "C50:",acc_c50/10,"KNN:",acc_knn/10))

