rm(list=ls(all=TRUE))
lib<-"d:\\qjt\\r\\mylibrary"
.libPaths(lib)
library(clustMixType)

data.all<-read.csv('Wholesale_customers_data.csv')
data.all$Channel<-as.factor(data.all$Channel)
data.all$Region<-as.factor(data.all$Region)
data.all$Fresh<-data.all$Fresh/max(data.all$Fresh)
data.all$Milk <-data.all$Milk/max(data.all$Milk)
data.all$Grocery <-data.all$Grocery/max(data.all$Grocery)
data.all$Frozen <- data.all$Frozen/max(data.all$Frozen)
data.all$Detergents_Paper <-data.all$Detergents_Paper/max(data.all$Detergents_Paper)
data.all$Delicassen <-data.all$Delicassen/max(data.all$Delicassen)

r<-kproto(data.all, 9, lambda = 2, iter.max = 100, nstart = 5, verbose = T)

