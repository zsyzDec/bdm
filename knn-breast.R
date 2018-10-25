# using knn to conduct emperiment on breast-cancer-wisconsin dataset 
rm(list=ls(all=TRUE))
library(class)
fname<-'breast-cancer-wisconsin.data'
bdata<-read.table(fname,sep=',')

idx<-which(bdata$V7!='?')
idx2<-which(bdata$V7=='?')
bmean<-sum(as.numeric(bdata[idx,'V7']))%/%length(idx)
bdata[idx2,'V7']<-bmean
bdata$V7<-as.numeric(bdata$V7)

test_idx<-1:100
train_idx<-101:nrow(bdata)

train<-bdata[train_idx,1:10]
train_label<-bdata[train_idx,11]
test<-bdata[test_idx,1:10]
test_label<-bdata[test_idx,11]

nn <- knn(train = train, test = test, cl = train_label, k=9)
acc<-length(which(nn==test_label))/length(nn)
print(acc)
