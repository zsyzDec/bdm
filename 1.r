top.bacon.searching.cities <- data.frame( city = c("Seattle", "Washington", "Chicago", "New York", "Portland", "St Louis", "Denver", "Boston","Minneapolis", "Austin", "Philadelphia", "San Francisco", "Atlanta", "Los Angeles", "Richardson"), rank = c(100, 96, 94, 93, 93, 92, 90, 90, 89, 87, 85, 84, 82, 80, 80))

top.bacon.searching.cities[1,]
#-----------------------------
    
i <- 5
repeat {
    if (i > 25){
        break  
    }  else {
        print(i); 
        i <- i + 5;
    }
}
#-----------------------------
mlist <- seq(from=5, to=25, by=5)
for (i in mlist){
    print(i)  
} 
#----------------------------
#将1-100中的奇数输出到控制台

rm(list=ls(all=TRUE))

ilist<-1:100

for (i in ilist){
    if(i%%2==0){
        next
    }
    print(i)
}
#--------------------------------------
#输出100以内的素数
for(i in c(2:100)){
    
    for(j in c(2:i)){
        if(i%%j==0){
            break;
        }
    }
    if(i==j){
        print(i)
    }
}

#--------------------------------------
#产生一个向量，它的元素值是x=n^2+10,n 是1到100的值

item<-c()
a<-c(1:100)
for(i in a){
    x=i^2+10
    item<-c(item,x)
}
for(i in 1:length(a)){
    print(paste(a[i],":",item[i]))
}
#----------------------------------------------
compute <- function(x) {
    return(x^2 + 3)
}

r<-compute(10)
print(r)

#-----------------------
#定义一个函数，它只有一个参数，它的参数是一个数值向量。该函数完成向量求和的功能。
vec_sum<-function(vec){
    s<-0
    for(item in vec){
        s<-s+item
    }
    return (s)
}

print(vec_sum(c(1,2,3,4)))

#----------------------------
#定义一个函数，它的参数是一个整数。该函数寻找从1到该参数中的所有素数。结果放到一个vector中返回

susu<-function(n){
    res<-c()
    for(i in c(2:n)){
        
        for(j in c(2:i)){
            if(i%%j==0){
                break;
            }
        }
        if(i==j){
            res<-c(res,i)
        }
    }
    return (res)
}

print(susu(30))
#---------------------------------
#定义一个函数myfind，它的参数就是这个data frame。该函数返回最高成绩和最低成绩的学生姓名。

dat <-data.frame(grad=c(67,78,90), name=c('allen','ann','joan'))

myfind<-function(dat){
    max_val<-0
    min_val<-101
    for(i in 1:nrow(dat)){
        if(dat$grad[i]>max_val){
            max_val<-dat$grad[i]
            max_name<-dat$name[i]
        }
        if(dat$grad[i]<min_val){
            min_val<-dat$grad[i]
            min_name<-dat$name[i]
        }
    }
    return(list(max=max_name, min=min_name))
}

r<-myfind(dat)
print(paste(r$max,r$min))
