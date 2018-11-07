# using SVM to conduct experiment on adult

rm(list=ls(all=TRUE))
.libPaths('d:/qjt/r/mylibrary')
library(e1071)
library(dummies)

adult<-read.table("adult.data",sep=",",header=F,strip.white=TRUE)

#1. v2,v7,v14 有缺失值，删除缺失�?
idx.missing<-unique(c(which(adult$V14=='?'),which(adult$V7=='?'),which(adult$V2=='?')))
adult.data<-adult[-idx.missing,]

#2. 对连续属性规范化
col.numeric<-c("V1","V3","V5","V11","V12","V13")
adult.matrix<-as.matrix(adult.data[,col.numeric])
adult.max<-apply(adult.matrix,MARGIN=2,FUN=max)
adult.scale<-scale(adult.matrix, center=F, scale=adult.max)
adult.data[,col.numeric]<-adult.scale

#3. V7,V14使用supervised ratio为SVN预处理数据集
adult.svm.data<-data.frame(adult.data)

source('supervised_ratio.R')
adult.svm.data$V7 <-supervised_ratio(adult.data,15,7,'>50K')
adult.svm.data$V14<-supervised_ratio(adult.data,15,14,'>50K')

#4. V2,V4,V6,V8,V9,V10进行one-hot编码
adult.svm.data<-dummy.data.frame(adult.svm.data,sep=".",names=c("V2","V4","V6","V8","V9","V10"))

# 6. evaluate a SVM using 10-fold cross validation
size<-nrow(adult.svm.data)
cols<-ncol(adult.svm.data)

index<-sample(1:size,size, replace = F)
folds    <- 10
bin      <- size%/%folds
idx.start<-1
acc.svm  <-0

for (k in 0:(folds-1)){
    idx.end<-ifelse(idx.start+bin>size,size,idx.start+bin)
    idx.test <- index[idx.start:idx.end]
    test <-adult.svm.data[idx.test,1:(cols-1)]
    test.label<-adult.svm.data[idx.test,'V15']
    train<-adult.svm.data[-idx.test,]
    train.svm <- train[,1:(cols-1)]
    train.svm.label <- train[,"V15"]
    
    model <- svm(train.svm, train.svm.label, type="nu-classification", nu=0.3)

    # test 
    pred <- predict(model, test)
    
    acc.svm<-length(which(pred==test.label))/length(pred) + acc.svm 
    idx.start<-idx.end+1
    print(k)
}
print(paste("SVM ACC:",acc.svm/10))
