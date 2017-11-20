centerColumn = function(data,columnName) {
 newName = (paste(columnName,"Centered",sep="."))
 data[,newName] <- data[,columnName] - mean(data[,columnName], na.rm = TRUE)
 data[,newName] <- data[,newName] / sd(data[,columnName], na.rm = TRUE)
 return(data)
}

data = read.csv("../Submiterator-master/order-preference-trials.tsv", sep="\t")
dataS = read.csv("../Submiterator-master/order-preference-subject_information.tsv", sep="\t")

#dataS = dataS[FALSE,]
#data = data[FALSE,]

for(i in c()) {
  dataNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-trials.tsv",sep=""), sep="\t")
  dataNew$workerid = dataNew$workerid + i*9
  data = rbind(data, dataNew)

  dataSNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-subject_information.tsv", sep=""), sep="\t")
  dataSNew$workerid = dataSNew$workerid + i*9
  dataS = rbind(dataS, dataSNew)
}

data = merge(data, dataS, by=c("workerid"))




getSubjRatings = function() {
 dataSubj1 = read.table("subjectivity-trials.csv",header=TRUE,sep=",")
  dataSubj1$X = 1
  dataSubj1$language = "UNK"

  dataSubj2 = read.table("13-subjectivity-trials.csv",header=TRUE,sep=",")
  dataSubj =rbind(dataSubj1, dataSubj2)
  dataSubj = aggregate(dataSubj["response"],by=c(dataSubj["predicate"], dataSubj["class"]), mean, na.rm=TRUE)

  dataSubj$subjectivity = dataSubj$response
  dataSubj$adjective = dataSubj$predicate
  dataSubj$response = NULL
  dataSubj$predicate = NULL
  return(dataSubj)
}

dataSubj = getSubjRatings()

data = merge(data, dataSubj, by=c("adjective"))

library(lme4)
summary(lmer(response_1 ~ subjectivity + (subjectivity|workerid) + (1|adjective) + (1|workerid), data=data))



library(tidyverse)
# is there faultless disagreement data with all adjectives?
#faultless = read.csv("2-faultless-disagreement.csv") %>% rename(faultless = response, adjective = predicate )
#faultless = aggregate(faultless["faultless"], by=c(data["class"]), mean)

byClass = aggregate(c(data["subjectivity"], data["response_0"], data["response_1"], data["response_2"]), by=c(data["class"]), mean)
byClass = merge(byClass, faultless, by=c("class"))
byClass = byClass[order(byClass$subjectivity),]



detach("package:data.table", unload=TRUE)
source('helpers.R')
#source("rlang")
for(i in (0:2)) {
   name = paste("response_",i,sep="") # sym(...)
   agr = data %>%
     rename_(.dots = list(value = name)) %>%
     group_by(class) %>%
     summarise(Mean = mean(value), CILow = ci.low(value), CIHigh = ci.high(value))
   dodge = position_dodge(.9)
   
   #agr = agr[order(agr$classId),]
   
   # make sure classes are ordered by increasing subjectivity
   agr$class = factor(agr$class, levels=byClass$class)
   
   plot = ggplot(agr, aes(x=class,y=Mean)) +
     geom_bar(stat="identity",position=dodge) +
     geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
   scale_x_discrete( labels = function( labels ) { # user aaiezza on https://stackoverflow.com/questions/19567986/overlapping-axis-labels-in-r
                              fixedLabels <- c() 
                              for ( l in 1:length( labels ) ) { 
                                        fixedLabels <- c( fixedLabels, paste0( ifelse( l %% 2 == 0, '', '\n' ), labels[l] ) ) 
                              }
                               return( fixedLabels ) } ) +xlab(NULL) + ylab(NULL)
   
   ggsave(paste('plots/response_',i,'_by_class.pdf',sep=""), plot=plot, width=7, height=4)
}







> agg = aggregate(c(data["subjectivity"],data["response_0"],data["response_1"],data["response_2"]), by=c(data["class"]), mean)
> agg[order(agg$subjectivity),]

#dataAgg = aggregate(c(data["response_0"],data["response_1"], data["response_2"], data["response_3"], data["response_4"], data["response_5"]), by=(data["adjective"]), mean)

#dataAgg = merge(dataAgg, dataSubj, by=c("adjective"))


