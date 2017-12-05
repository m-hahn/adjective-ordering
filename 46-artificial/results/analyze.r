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

for(i in (2)) {
  dataNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-trials.tsv",sep=""), sep="\t")
  dataNew$workerid = dataNew$workerid + i*9
  data = rbind(data, dataNew)

  dataSNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-subject_information.tsv", sep=""), sep="\t")
  dataSNew$workerid = dataSNew$workerid + i*9
  dataS = rbind(dataS, dataSNew)
}

data = merge(data, dataS, by=c("workerid"))



library(tidyverse)

data = data %>% mutate(adjective_response = ifelse(response_field_1 == "an adjective", response_1, ifelse(response_field_2 == "an adjective", response_2, response_3)))
data = data %>% mutate(noun_response = ifelse(response_field_1 == "a noun", response_1, ifelse(response_field_2 == "a noun", response_2, response_3)))
data = data %>% mutate(verb_response = ifelse(response_field_1 == "a verb", response_1, ifelse(response_field_2 == "a verb", response_2, response_3)))

means = aggregate(c(data["adjective_response"], data["verb_response"], data["noun_response"]), by=c(data["predicate1"]), mean) %>% rename(predicate= predicate1)

m = lmer(adjective_response ~ (1|predicate1) + (1|workerid), data=data)
adj_intercepts = coef(m)$predicate1 %>% select(adjective_intercept=1)

m = lmer(verb_response ~ (1|predicate1) + (1|workerid), data=data)
verb_intercepts = coef(m)$predicate1 %>% select(verb_intercept=1)

m = lmer(noun_response ~ (1|predicate1) + (1|workerid), data=data)
noun_intercepts = coef(m)$predicate1 %>% select(noun_intercept=1)
noun_intercepts$Row.names = rownames(noun_intercepts)

intercepts = merge(adj_intercepts, verb_intercepts, by="row.names", all.x=TRUE)
intercepts = merge(intercepts, noun_intercepts, by="Row.names", all.x=TRUE)
intercepts = intercepts %>% rename(predicate = Row.names)

intercepts = merge(intercepts, means, by=c("predicate"))

write.csv(intercepts, file="pos-ratings.tsv")

