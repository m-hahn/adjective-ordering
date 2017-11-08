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

> agg = aggregate(c(data["subjectivity"],data["response_0"],data["response_1"],data["response_2"]), by=c(data["class"]), mean)
> agg[order(agg$subjectivity),]

#dataAgg = aggregate(c(data["response_0"],data["response_1"], data["response_2"], data["response_3"], data["response_4"], data["response_5"]), by=(data["adjective"]), mean)

#dataAgg = merge(dataAgg, dataSubj, by=c("adjective"))


