# germany credit data analysis
rm(list=ls(all=TRUE))

mypredict<-function(modle, test){
  res<-predict(modle,  newdata=test, type='response')
  res<-sapply(res, function(x){if(x>0.5) 'good' else 'bad'})
  return(length(which(res==test$y))*1.0/length(res))
}

gdata<-read.table('german.data')

sex<-sapply(gdata$V9, function(x) switch(x,
                                      A91="male",
                                      A92="female",
                                      A93="male",
                                      A94="male",
                                      A95="female",
                                      "null"))
gdata$sex<-as.factor(sex)


marital<-sapply(gdata$V9, function(x) switch(x,
                                         A91="m",
                                         A92="m",
                                         A93="s",
                                         A94="m",
                                         A95="s",
                                         "null"))
gdata$marital<-as.factor(marital)

gdata$y<-as.factor(sapply(gdata$V21, function(x) switch(x,"good","bad")))
gmodle<-glm(y~V1+V2+V3+V4+V5+V6+V7+V8+V10+V11+V12+V13+V14+V15+V16+V17+V18+V19+V20+sex+marital,family=binomial, data=gdata)
nothing <- glm(y ~ 1,family=binomial, data=gdata)
forwards <- step(nothing,scope=list(lower=formula(nothing),upper=formula(gmodle)), direction="forward")




p1<-0
p2<-0
ind<-c(1:nrow(gdata))
size<-nrow(gdata)
step<-size/10
for(k in c(1:10)){
    if(k==10){
        testind<-c((k*step-step+1):size)        
    }else{
        testind<-c((k*step-step+1):(k*step))
    }
    trainind<-ind[which(!ind%in%testind)]
    test<-gdata[testind,]
    train<-gdata[trainind,]
    gmodle<-glm(y~V1+V2+V3+V4+V5+V6+V7+V8+V10+V11+V12+V13+V14+V15+V16+V17+V18+V19+V20+sex+marital,family=binomial, data=train)
    p1<-p1+mypredict(gmodle, test)
    smodle<-glm(y ~ V1 + V2 + V3 + V4 + V6 + V10 + V9 + V8 + V5 + V14 + V20 + V13 + V19 + V15, family=binomial, data=train)
    p2<-p2+mypredict(smodle, test)
}

print(p1/10)
print(p2/10)
  
  