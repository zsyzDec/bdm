# using C5.0 conduct experiments on breast-cancer-wiscons dataset 

lib<-"d:\\qjt\\R\\mylibrary"
.libPaths(lib)
library(C50)

fname<-'breast-cancer-wisconsin.data'
bdata<-read.table(fname,sep=',')

idx<-which(bdata$V7!='?')
idx2<-which(bdata$V7=='?')
bmean<-sum(as.numeric(bdata[idx,'V7']))%/%length(idx)
bdata[idx2,'V7']<-bmean
bdata$V7<-as.numeric(bdata$V7)

test_idx<-1:100
train_idx<-101:nrow(bdata)

train<-bdata[train_idx,]
train$V11<-as.factor(train$V11)
test<-bdata[test_idx,1:10]
test_label<-bdata[test_idx,11]

modle<-C5.0(V11 ~.,data=train, winnow = F,noGlobalPruning = F,fuzzyThreshold = F)
res<-predict(modle, test)
acc<-length(which(res==test_label))/length(res)
print(acc)

