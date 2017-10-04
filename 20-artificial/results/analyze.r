centerColumn = function(data,columnName) {
 newName = (paste(columnName,"Centered",sep="."))
 data[,newName] <- data[,columnName] - mean(data[,columnName], na.rm = TRUE)
 data[,newName] <- data[,newName] / sd(data[,columnName], na.rm = TRUE)
 return(data)
}

data = read.csv("../Submiterator-master/order-preference-trials-postprocessed.tsv", sep="\t")
dataS = read.csv("../Submiterator-master/order-preference-subject_information.tsv", sep="\t")

#dataS = dataS[FALSE,]
#data = data[FALSE,]

for(i in (2:3)) {
  dataNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-trials-postprocessed.tsv",sep=""), sep="\t")
  dataNew$workerid = dataNew$workerid + i*9
  data = rbind(data, dataNew)

  dataSNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-subject_information.tsv", sep=""), sep="\t")
  dataSNew$workerid = dataSNew$workerid + i*9
  dataS = rbind(dataS, dataSNew)
}

data$correctQuiz = (data$correct_response == data$quiz_response)


correctByWorker = aggregate(data["correctQuiz"], by=c(data["workerid"]), mean, na.rm=TRUE)
dataS = merge(dataS, correctByWorker)
dataS = dataS[dataS$correctQuiz > 0.85,]

data = merge(data, dataS, by=c("workerid"))

data$correct = (data$correct_response == data$quiz_response)

aggregate(data["correct"], by=c(data["condition"]), mean, na.rm=TRUE)

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

data4$colorRelevant = (data4$relevant_adjective %in% c("red", "green", "blue"))
data4$alienRelevant = (data4$relevant_adjective %in% c("rofky", "glab"))

#summary(lmer(response ~ colorRelevant*alienWordIsFirst + alienRelevant*alienWordIsFirst + alienWordIsFirst*condition.Centered + (1|workerid), data=data4))



###########################################
# from the non-contextualized data
###########################################

data2 = data2[is.na(data2$relevant_adjective),]


data2 = centerColumn(data2, "alienWordIsFirst")
#summary(lmer(response ~ a.Centered*condition.Centered + (1|workerid) + (1|predicate1) + (1|predicate2), data=data2))
library(lme4)

data2$forAlienFirst = ifelse(data2$a1, data2$response, (1-data2$response))

#OLD summary(lmer(response ~ alienWordIsFirst.Centered*condition.Centered + (condition.Centered|workerid) + (1|workerid) + (alienWordIsFirst.Centered|nonAlienAdjective) + (1|nonAlienAdjective), data=data2))
#have to remove nonAlienAdjective slopes, note that there are only 5 non-Alien words

#summary(lmer(response ~ alienWordIsFirst.Centered*condition.Centered + (alienWordIsFirst.Centered|workerid) + (condition.Centered|workerid) + (1|workerid), data=data2))

summary(lmer(response ~ alienWordIsFirst.Centered*condition.Centered + (alienWordIsFirst.Centered|workerid) + (condition.Centered|workerid) + (1|workerid), data=data2))



# this is relevant for 14
data$bothAreAlien = (data$a1 & data$a2)
if(max(data2$bothAreAlien) > 0) {
 crash()
}


# both adjectives are Alien adjectives
data3 = data[data$bothAreAlien,]
data3 = data3[!is.na(data3$predicate1),]

# TODO apparently, there are no such cases?
data3 = data3[is.na(data3$relevant_adjective),]

data3$subjectiveFirst = (as.character(data3$predicate1) == as.character(data3$adjective1))

# PROBLEM NEED TO EXLUCDE 'RELEVANT_ADJ' ITEMS
#summary(lmer(response ~ subjectiveFirst + (1|workerid) + (subjectiveFirst|workerid), data=data3))

# evaluating production (TODO need to separate the click- and textfield-based parts)

data.free = data[data$slide_number > 80,]

data.click = data[data$slide_number < 80,]

data.free$glabOrRofkyFirst.Transformed = ifelse(data.free$glabOrRofkyFirst == "Q_glab_rofky", 1, ifelse(data.free$glabOrRofkyFirst == "Q_rofky_glab", 0, NA))
data.free$glabOrColorFirst.Transformed = ifelse(data.free$glabOrColorFirst == "R_glab_COLOR", 1, ifelse(data.free$glabOrColorFirst == "R_COLOR_glab", 0, NA))
data.free$rofkyOrColorFirst.Transformed = ifelse(data.free$rofkyOrColorFirst == "S_rofky_COLOR", 1, ifelse(data.free$rofkyOrColorFirst == "S_COLOR_rofky", 0, NA))

summary(glm(glabOrColorFirst.Transformed ~ adjective1, family="binomial", data=data.free))
summary(glm(rofkyOrColorFirst.Transformed ~ adjective1, family="binomial", data=data.free))
summary(glm(glabOrRofkyFirst.Transformed ~ adjective1, family="binomial", data=data.free))

########################

data.click$glabOrRofkyFirst.Transformed = ifelse(data.click$glabOrRofkyFirst == "Q_glab_rofky", 1, ifelse(data.click$glabOrRofkyFirst == "Q_rofky_glab", 0, NA))
data.click$glabOrColorFirst.Transformed = ifelse(data.click$glabOrColorFirst == "R_glab_COLOR", 1, ifelse(data.click$glabOrColorFirst == "R_COLOR_glab", 0, NA))
data.click$rofkyOrColorFirst.Transformed = ifelse(data.click$rofkyOrColorFirst == "S_rofky_COLOR", 1, ifelse(data.click$rofkyOrColorFirst == "S_COLOR_rofky", 0, NA))

summary(glm(glabOrColorFirst.Transformed ~ adjective1, family="binomial", data=data.click))
summary(glm(rofkyOrColorFirst.Transformed ~ adjective1, family="binomial", data=data.click))
summary(glm(glabOrRofkyFirst.Transformed ~ adjective1, family="binomial", data=data.click))


#aggregate(data3["response"], by=c(data3["subjectiveFirst"]), mean)


######################

agr = data %>%
  group_by(condition1, condition2, noun) %>%
  summarise(Mean = mean(response), CILow = ci.low(response), CIHigh = ci.high(response))
dodge = position_dodge(.9)

ggplot(agr, aes(x=condition1,y=Mean,fill=condition1)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~noun)



agr = data %>%
  group_by(condition2) %>%
  summarise(Mean = mean(response), CILow = ci.low(response), CIHigh = ci.high(response))
dodge = position_dodge(.9)

ggplot(agr, aes(x=condition2,y=Mean,fill=condition2)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) 



agr = data %>%
  group_by(predicate1) %>%
  summarise(Mean = mean(response), CILow = ci.low(response), CIHigh = ci.high(response))
dodge = position_dodge(.9)

ggplot(agr, aes(x=predicate1,y=Mean,fill=predicate1)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~predicate1)




dataSpecial = data[data$condition1 != data$condition2,]

agr = dataSpecial %>%
  group_by(condition1, predicate1, noun) %>%
  summarise(Mean = mean(response), CILow = ci.low(response), CIHigh = ci.high(response))
dodge = position_dodge(.9)

ggplot(agr, aes(x=condition1,y=Mean,fill=condition1)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~noun + predicate1)



agr = dataSpecial %>%
  group_by(condition1) %>%
  summarise(Mean = mean(response), CILow = ci.low(response), CIHigh = ci.high(response))
dodge = position_dodge(.9)

ggplot(agr, aes(x=condition1,y=Mean,fill=condition1)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) 



