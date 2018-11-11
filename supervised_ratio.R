# The functions for supervised ratio and WoE
# allen -- 2018.11
# 
# data is a data frame
# dependent is target attribute (factor), index of column
# independent is a categorical attribute, an index of column
# positive is a class in dependent, it is set as positive class
# return a vector corresponding to independent variable
supervised_ratio <- function(dat, dependent, independent, positive){
    tab<-aggregate(x=rep(1, nrow(dat)), 
                   by=list(dat[,independent],dat[,dependent]),
                   FUN=sum)
    r<-sapply(X=dat[,independent], FUN=function(x){
        # browser()
        ci <- as.numeric(tab[tab$Group.1==x & tab$Group.2==positive,][3])
        ni <- as.numeric(tab[tab$Group.1==x & tab$Group.2!=positive,][3])
        res<-ci/(ci+ni)
        
        return (ifelse(is.na(res),0,res))
    })
    return(unlist(r))
}

woe<-function(dat, dependent, independent, positive){
    TC<-length(dat[,dependent]==positive)
    TN<-length(dat[,dependent]!=positive)
    tab<-aggregate(x=rep(1, nrow(dat)), 
                   by=list(dat[,independent],dat[,dependent]),
                   FUN=sum)
    r<-sapply(X=dat[,independent], FUN=function(x){
        # browser()
        ci <- as.numeric(tab[tab$Group.1==x & tab$Group.2==positive,][3])
        ni <- as.numeric(tab[tab$Group.1==x & tab$Group.2!=positive,][3])
        return ((ci*TN)/(ni*TC))
    })
    return(unlist(r))
}
    
