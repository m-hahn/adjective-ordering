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

for(i in (2:3)) {
  dataNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-trials.tsv",sep=""), sep="\t")
  dataNew$workerid = dataNew$workerid + i*9
  data = rbind(data, dataNew)

  dataSNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-subject_information.tsv", sep=""), sep="\t")
  dataSNew$workerid = dataSNew$workerid + i*9
  dataS = rbind(dataS, dataSNew)
}

data = merge(data, dataS, by=c("workerid"))

data$a1 = !(data$predicate1 %in% c("big", "small", "blue", "red", "green"))
data$a2 = !(data$predicate2 %in% c("big", "small", "blue", "red", "green"))

dataAdj = data[,c('workerid','adjective1', 'adjective2')]
dataAdj = subset(dataAdj, !duplicated(dataAdj$workerid))

data$adjective1 = NULL
data$adjective2 = NULL

data = merge(data, dataAdj, by=c("workerid"))

data$condition1 = ((as.character(data$predicate1) == as.character(data$adjective1)) | (as.character(data$predicate2) == as.character(data$adjective1)))
data$condition2 = ((as.character(data$predicate1) == as.character(data$adjective2)) | (as.character(data$predicate2) == as.character(data$adjective2)))

data$condition = data$condition1

check = (data$condition1 | data$condition2)

data$a = data$a1 - data$a2

###########################################
# items that contain exactly one alien word
###########################################
data2 = data[data$a != 0,]
data2 = centerColumn(data2, "condition")
data2$alienWordIsFirst = data2$a

data2$responseAlienFirst = (data2$alienWordIsFirst == 1) * data2$response + (data2$alienWordIsFirst == -1) * (1-data2$response)

library(lme4)
summary(lmer(responseAlienFirst ~ condition1 + (1|workerid), data=data2))

###########################################
# looking both at contextualized and at out-of-context data
###########################################

data2$nonAlienAdjective = ifelse(data2$a1, as.character(data2$predicate2), as.character(data2$predicate1))

data2$nonAlienAdjectiveIsColor = (data2$nonAlienAdjective %in% c("red", "green", "blue"))

source('helpers.R')
library(ggplot2)
library(tidyverse)

data5 = rbind(data2)

data5$inContext = !is.na(data5$relevant_adjective)
library(lme4)
data5 = centerColumn(data5, "inContext")
data5 = centerColumn(data5, "alienWordIsFirst")
data5 = centerColumn(data5, "nonAlienAdjectiveIsColor")

summary(lmer(responseAlienFirst ~ nonAlienAdjectiveIsColor.Centered*inContext.Centered*condition.Centered + (1|workerid), data=data5))




data5$nonAlienAdjectiveIsColor.Label = ifelse(data5$nonAlienAdjectiveIsColor, "Color", "Size")
data5$inContext.Label = ifelse(data5$inContext, "In Context", "Out of Context")
data5$condition.Label = ifelse(data5$condition, "scalar", "objective")

agr = data5 %>%
  group_by(condition.Label, nonAlienAdjectiveIsColor.Label, inContext.Label) %>%
  summarise(Mean = mean(responseAlienFirst), CILow = ci.low(responseAlienFirst), CIHigh = ci.high(responseAlienFirst))
dodge = position_dodge(.9)

pdf('plots/order-ratings.pdf')
ggplot(agr, aes(x=condition.Label,y=Mean,fill=condition.Label)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~nonAlienAdjectiveIsColor.Label+inContext.Label)+
  ylab('Rating for Alien First') +
  xlab('Type of Alien Adjective')
dev.off()



#summary(lmer(response ~ nonAlienAdjectiveIsColor*inContext.Centered*alienWordIsFirst.Centered*condition.Centered + (1|workerid), data=data5))

###########################################
# from the contextualized data
###########################################

data4 = data2[!is.na(data2$relevant_adjective),]

# data with color + alien

#data4$colorRelevant = (data4$relevant_adjective %in% c("red", "green", "blue"))
#data4$alienRelevant = (data4$relevant_adjective %in% c("rofky", "glab"))

#summary(lmer(response ~ colorRelevant*alienWordIsFirst + alienRelevant*alienWordIsFirst + alienWordIsFirst*condition.Centered + (1|workerid), data=data4))
# no interaction


###########################################
# from the non-contextualized data
###########################################

# non-contextualized analysis

data2 = data2[is.na(data2$relevant_adjective),]


data2 = centerColumn(data2, "alienWordIsFirst")
#summary(lmer(response ~ a.Centered*condition.Centered + (1|workerid) + (1|predicate1) + (1|predicate2), data=data2))
library(lme4)

data2$forAlienFirst = ifelse(data2$a1, data2$response, (1-data2$response))

data2 = centerColumn(data2, "nonAlienAdjectiveIsColor")

# the important analysis
summary(lmer(response ~ alienWordIsFirst.Centered*condition.Centered + (alienWordIsFirst.Centered|workerid) + (condition.Centered|workerid) + (1|workerid), data=data2))
# interaction, but it appears only when using random slopes
# not robust across analyses
summary(lmer(responseAlienFirst ~ condition.Centered + (alienWordIsFirst.Centered|workerid) + (condition.Centered|workerid) + (1|workerid), data=data2))

# interaction disappears:
summary(lmer(response ~ nonAlienAdjectiveIsColor.Centered*alienWordIsFirst.Centered*condition.Centered + (1|workerid), data=data2))


