rm(list=ls(all=TRUE))
#------------------------------
#将womenroles数据集中，按照教育程度和性别分组，统计每组投票总数数，并会柱状图
dat<-read.table('tj/womenroles.txt', header=T)
dat$num<-rep(1, nrow(dat))

a<-aggregate(dat$num, by=list(dat$education,dat$gender), FUN=sum)
b<-a$x[1:2]
b<-c(b,0)
b<-c(b,a$x[3:nrow(a)])
barVal<-t(matrix(b,21,2))
windows()
barplot(barVal, beside=T, legend.text=c('female','male'),names.arg = c(1:21), ylab="Votes")
box(bty="l")
#----------------------------------
#画出这两条曲线在一张图上。其中一条曲线是红色，一条是黑色
dat<-read.table('banalysis/sin.txt')
x<-c(1:nrow(dat))
windows()
yLim<-range(c(dat$V1,dat$V2,dat$V2+0.3))
xLim<-range(x)
plot(x,dat$V1,type="l",col="red", ylim=yLim, xlim=xLim)
lines(x,dat$V2)
lines(x,dat$V2+0.3)
abline(h=mean(dat$V1))
#-------------------
windows()
x<-rnorm(10000,mean=0,sd=1)
hist(x,40, prob=T)
lines(density(x),col='red')
#------------------------------
x<-sample(c(1:10),100,replace=T, prob=c(0.2,0.1,0.01,0.02,0.03,0.04,0.05,0.1,0.3,0.15))
plot(table(x)/length(x),type="h")
#------------------------------
windows()
par(mfrow=c(2,2))
Quantile <- seq(from=0, to=1, length.out=30)
plot(Quantile, dbeta(Quantile, 2, 4), type="l", main="First")
plot(Quantile, dbeta(Quantile, 4, 2), type="l", main="Second")
plot(Quantile, dbeta(Quantile, 1, 1), type="l", main="Third")
plot(Quantile, dbeta(Quantile, 0.5, 0.5), type="l", main="Fourth")
#-----------------------
#提取年份，一种是我上课用的方法，一种是一个同学更简单的方法
dat<-read.csv('banalysis/1.csv')
dat$crtYear<-sapply(dat$CrtTime, FUN=function(x){unlist(strsplit(s,"[-]"))[1]})
dat$crtYear2<-substring(dat$CrtTime,1,4)

#------------------------------------
#规范化
dMax<-max(dat$BidAmt)
dMin<-min(dat$BidAmt)
dat$BidAmt<-sapply(dat$BidAmt, FUN=function(x){(x-dMin)/(dMax-dMin)})
