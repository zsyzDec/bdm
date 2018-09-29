rm(list=ls(all=TRUE))

#------------------
# 随机产生一个10*10的二维矩阵，数值[-1,1]。将所有小余0的值设为0.

mat<-matrix(runif(100, -1, 1),10,10)
sapply(mat, FUN=function(x){if(x<0) 0 else x})

#-------------------
#挑选iris数据中类别为Iris-setosa的记录，但不包含类别这一列

dat<-read.table('tj/iris.data', sep=",")
removes<-c('V5')
subset(dat,subset=V5=='Iris-setosa', select=!(names(dat)%in%removes))

#-------------------
#对iris数据集，统计每个类别的记录个数
dat<-read.table('tj/iris.data', sep=",")
dat$num<-1
tapply(dat$num,dat$V5,FUN=sum)

#-----------------------
#iris数据集按照V5列的每个类别分组，统计V1~V4列上的每组的均值
dat<-read.table('tj/iris.data', sep=",")
aggregate(dat[,c('V1','V2','V3','V4')],by=list(dat$V5), FUN=mean)

#-------------------------
#Womenroles数据集中，按照education和gender列分组。统计每组投票vote的数目
dat<-read.table('tj/womenroles.txt', header=T, sep=" ")
dat$num<-1
aggregate(dat[,'num'],by=list(dat$education,dat$gender,dat$vote),FUN=sum)

#----------------------
#将iris.data文件中，第一列的值大于均值的记录选出
dat<-read.table('tj/iris.data', sep=",")
m_mean<-mean(dat$V1)
idx<-which(dat$V1>m_mean)
dat[idx,]

#-------------------------
#将iris.data中第5列中的值转换成数值。建立一个新的列。
dat<-read.table('tj/iris.data', sep=",")
dat$new<-sapply(dat$V5, FUN=function(x){
    switch(x,
        'Iris-setosa'=1,
        'Iris-versicolor'=2,
        'Iris-virginica'=3,
        0
    )
})

#-----------------------
.libPaths("d:/qjt/R/mylibrary")
library(fun)
gomoku(n = 19)

#-----------
source('func.r')
add(1,3)
#------------------
load('lx/ds.rdata')
plot(ds$dist, ds$speed)





