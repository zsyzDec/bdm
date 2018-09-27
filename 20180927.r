rm(list=ls(all=TRUE))

#-----------------------
# 统计抽样数的数目
x<-c(1:10)
y<-sample(x,1000,replace=T)

num<-rep(0,10)

for(i in y){
    num[i]<-num[i]+1
}

print(num)
#-------------------------
# 读写文件
dat<-read.table("tj/r.txt",header=T, sep=",")
t<-dat$name.last
dat$name.last<-dat$name.first
dat$name.first<-t

write.table(dat, "r4.txt", sep="," , append=F, row.names=F,quote = F,col.names = F)
#-----------------------------
# 抽样文件的部分记录
dat<-read.table("tj/womenroles.txt",header=T, sep=" ")
size<-nrow(dat)%/%10
idx<-c(1:nrow(dat))
sidx<-sample(idx, size, replace=F)
sdat<-dat[sidx,]
write.table(sdat, "new_womenroles.txt", append=F, row.names=F,quote = F)
#----------------------------
# iris
dat<-read.table("tj/iris.data", header=F, sep=",")
m<-mean(dat$V1)
dat$mean<-rep(m, nrow(dat))

#————————————————————————————————————————
# apply
d <- data.frame(x=1:5, y=6:10)
#d<-lapply(d,function(x) 2^x)
d<-lapply(d,max)
#-------------------------
# iris规范化
dat<-read.table("iris.data",sep=",",header=F,strip.white=TRUE)
maxValue<-apply(dat, MARGIN=2, FUN=max)
remove<-c('V5')
names<-names(dat)
names<-names[!(names%in%remove)]

for(col in names){
    dat[col]<-sapply(dat[col],FUN=function(x){x/as.numeric(maxValue[col])})
}




