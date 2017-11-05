#NEW
#data$ADJ1_ADJ2 = ifelse(data$ADJ2OrADJ1First == "Q_ADJ1_ADJ2", 1, ifelse(data$ADJ2OrADJ1First == "Q_ADJ2_ADJ1", -1, 0))



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

for(i in (2:4)) {
  dataNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-trials-postprocessed.tsv",sep=""), sep="\t")
  dataNew$workerid = as.numeric(dataNew$workerid) + i*9
  data = rbind(data, dataNew)

  dataSNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-subject_information.tsv", sep=""), sep="\t")
  dataSNew$workerid = as.numeric(dataSNew$workerid) + i*9
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


#######################################
# ANALYSIS I: analyze items where both adjectives are alien words
data7 = data[!is.na(data$predicate1) & data$a1 + data$a2 == 2,]
# there should be 3 datapoints per participant
# Also, data7$predicate1 == data7$predicate2 should not contain any TRUE entries

data7$subjectiveFirst = (as.character(data7$predicate1) == as.character(data7$adjective1))

data7$inContext = !is.na(data7$relevant_adjective)

data7 = centerColumn(data7, "inContext")
data7 = centerColumn(data7, "subjectiveFirst")

#############################
library(tidyverse)

subjectivity1 = aggregate(data$adj1_subj, by=c(data["workerid"]), mean, na.rm=TRUE)  %>% rename(subjectivity1=x)
subjectivity2 = aggregate(data$adj2_subj, by=c(data["workerid"]), mean, na.rm=TRUE)  %>% rename(subjectivity2=x)
disagreement1 = aggregate(data$adj1_disagreement, by=c(data["workerid"]), mean, na.rm=TRUE)  %>% rename(disagreement1=x)
disagreement2 = aggregate(data$adj2_disagreement, by=c(data["workerid"]), mean, na.rm=TRUE)  %>% rename(disagreement2=x)
subjDis = Reduce(function(x, y) merge(x,y, by=c("workerid")), list(subjectivity1, subjectivity2, disagreement1, disagreement2))

source('helpers.R')
library('tidyverse')
dataAOpposite = data7 %>% rename(pred1 = predicate2, pred2 = predicate1) %>% rename(predicate1 = pred1, predicate2 = pred2)
dataAOpposite$response = 1-dataAOpposite$response

dataA2 = rbind(data7, dataAOpposite)

dataA2$firstIsSubjective = (as.character(dataA2$predicate1) == as.character(dataA2$adjective1))

agr = dataA2 %>%
  group_by(predicate1, predicate2, firstIsSubjective) %>%
  summarise(Mean = mean(response), CILow = ci.low(response), CIHigh = ci.high(response))
dodge = position_dodge(.9)


plot = ggplot(agr, aes(x=predicate2, y=Mean, color=firstIsSubjective)) + 
   geom_bar(stat="identity",position=dodge) +
   geom_errorbar(aes(ymin=Mean-CILow, ymax=Mean+CIHigh), position=dodge,width=.25) +
   facet_wrap(~predicate1)
ggsave('plots/alien_pairs_merged.pdf', plot=plot) 






###########################################
# ANALYSIS II: items that contain exactly one alien word
###########################################
data2 = data[data$a != 0,]
data2 = centerColumn(data2, "condition")
data2$alienWordIsFirst = data2$a

data2$responseAlienFirst = (data2$alienWordIsFirst == 1) * data2$response + (data2$alienWordIsFirst == -1) * (1-data2$response)

library(tidyverse)


orderNorm = read.csv("../../36-artificial/results/alien-order-norm.tsv")
oNorm1 = orderNorm %>% rename(predicate1 = predicate, preference1 = response)
oNorm2 = orderNorm %>% rename(predicate2 = predicate, preference2 = response)
oNorm2$preference2 = 1-oNorm2$preference2
data2 = merge(data2, oNorm1, by=c("predicate1"))
data2 = merge(data2, oNorm2, by=c("predicate2"))




###########################################
# looking both at contextualized and at out-of-context data
###########################################

data2$nonAlienAdjective = ifelse(data2$a1, as.character(data2$predicate2), as.character(data2$predicate1))

data2$nonAlienAdjectiveIsColor = (data2$nonAlienAdjective %in% c("red", "green", "blue"))

source('helpers.R')
library(ggplot2)

data5 = rbind(data2)

data5$inContext = !is.na(data5$relevant_adjective)
library(lme4)
data5 = centerColumn(data5, "inContext")
data5 = centerColumn(data5, "alienWordIsFirst")
data5 = centerColumn(data5, "nonAlienAdjectiveIsColor")

# Added Oct 25: Control for preferences from experiment 35 (from people who only did ratings, without prior exposure)
summary(lmer(responseAlienFirst ~ nonAlienAdjectiveIsColor.Centered*inContext.Centered*condition.Centered + preference1 + preference2 + (1|workerid), data=data5))

data5 = centerColumn(data5, "subjectivity1")
data5 = centerColumn(data5, "subjectivity2")
data5 = centerColumn(data5, "disagreement1")
data5 = centerColumn(data5, "disagreement2")

summary(lmer(responseAlienFirst ~ subjectivity2.Centered*condition.Centered + subjectivity1.Centered*condition.Centered + disagreement1.Centered*condition.Centered + disagreement2.Centered*condition.Centered + (1|workerid), data=data5))


###################




data5$nonAlienAdjectiveIsColor.Label = ifelse(data5$nonAlienAdjectiveIsColor, "Color", "Size")
data5$inContext.Label = ifelse(data5$inContext, "In Context", "Out of Context")
data5$condition.Label = ifelse(data5$condition, "scalar", "objective")

agr = data5 %>%
  group_by(condition.Label, nonAlienAdjectiveIsColor.Label, inContext.Label) %>%
  summarise(Mean = mean(responseAlienFirst), CILow = ci.low.grouped(data5$responseAlienFirst, data5$workerid, (1:nrow(data5))), CIHigh = ci.high.grouped(data5$responseAlienFirst, data5$workerid, (1:nrow(data5))))
dodge = position_dodge(.9)

pdf('plots/order-ratings.pdf')
ggplot(agr, aes(x=condition.Label,y=Mean,fill=condition.Label)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~nonAlienAdjectiveIsColor.Label+inContext.Label)+
  ylab('Rating for Alien First') +
  xlab('Type of Alien Adjective')
dev.off()

#############################################
# further visualizations



dataOpposite = data5 %>% rename(pred1 = predicate2, pred2 = predicate1) %>% rename(predicate1 = pred1, predicate2 = pred2)
dataOpposite$response = 1-dataOpposite$response

data20 = rbind(data5, dataOpposite)

dataNA = data20[(data20$predicate2 %in% c("green","red","blue","small","big")),]

dataNA$alienIsSubjective = (as.character(dataNA$predicate1) == as.character(dataNA$adjective1))

agr = dataNA %>%
  group_by(predicate1, predicate2, alienIsSubjective) %>%
  summarise(Mean = mean(response), CILow = ci.low(response), CIHigh = ci.high(response))
dodge = position_dodge(.9)


plot = ggplot(agr, aes(x=predicate2, y=Mean, color=alienIsSubjective)) + 
   geom_bar(stat="identity",position=dodge) +
   geom_errorbar(aes(ymin=Mean-CILow, ymax=Mean+CIHigh), position=dodge,width=.25) +
   facet_wrap(~predicate1)
ggsave('plots/alien_english_merged.pdf', plot=plot) 





#library('ggfortify')
#plot1 = ggplot(agr, aes(x=predicate1, y=predicate2, fill=Mean)) + geom_tile()
#plot2 = ggplot(agr, aes(x=predicate1, y=predicate2, fill=Mean-CILow)) + geom_tile()
#plot3 = ggplot(agr, aes(x=predicate1, y=predicate2, fill=Mean+CIHigh)) + geom_tile()
#
#source('helpers.R')
#pdf('plots/alien_english_matrix_merged.pdf')
#multiplot(plot2, plot3, plot1, cols=2)
#dev.off()






###########################################


#summary(lmer(response ~ nonAlienAdjectiveIsColor*inContext.Centered*alienWordIsFirst.Centered*condition.Centered + (1|workerid), data=data5))

###########################################
# from the contextualized data
###########################################

#data4 = data2[!is.na(data2$relevant_adjective),]
#
## data with color + alien
#
#data4$colorRelevant = (data4$relevant_adjective %in% c("red", "green", "blue"))
#data4$alienRelevant = (data4$relevant_adjective %in% c("ADJ1", "ADJ2"))

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

data.free$ADJ2OrADJ1First.Transformed = ifelse(data.free$ADJ2OrADJ1First == "Q_ADJ2_ADJ1", 1, ifelse(data.free$ADJ2OrADJ1First == "Q_ADJ1_ADJ2", 0, NA))
data.free$ADJ2OrColorFirst.Transformed = ifelse(data.free$ADJ2OrColorFirst == "R_ADJ2_COLOR", 1, ifelse(data.free$ADJ2OrColorFirst == "R_COLOR_ADJ2", 0, NA))
data.free$ADJ1OrColorFirst.Transformed = ifelse(data.free$ADJ1OrColorFirst == "S_ADJ1_COLOR", 1, ifelse(data.free$ADJ1OrColorFirst == "S_COLOR_ADJ1", 0, NA))

summary(glm(ADJ2OrColorFirst.Transformed ~ adjective1, family="binomial", data=data.free))
summary(glm(ADJ1OrColorFirst.Transformed ~ adjective1, family="binomial", data=data.free))
summary(glm(ADJ2OrADJ1First.Transformed ~ adjective1, family="binomial", data=data.free))

########################

data.click$ADJ2OrADJ1First.Transformed = ifelse(data.click$ADJ2OrADJ1First == "Q_ADJ2_ADJ1", 1, ifelse(data.click$ADJ2OrADJ1First == "Q_ADJ1_ADJ2", 0, NA))
data.click$ADJ2OrColorFirst.Transformed = ifelse(data.click$ADJ2OrColorFirst == "R_ADJ2_COLOR", 1, ifelse(data.click$ADJ2OrColorFirst == "R_COLOR_ADJ2", 0, NA))
data.click$ADJ1OrColorFirst.Transformed = ifelse(data.click$ADJ1OrColorFirst == "S_ADJ1_COLOR", 1, ifelse(data.click$ADJ1OrColorFirst == "S_COLOR_ADJ1", 0, NA))

summary(glm(ADJ2OrColorFirst.Transformed ~ adjective1, family="binomial", data=data.click))
summary(glm(ADJ1OrColorFirst.Transformed ~ adjective1, family="binomial", data=data.click))
summary(glm(ADJ2OrADJ1First.Transformed ~ adjective1, family="binomial", data=data.click))





data.free$section = "free"
data.click$section = "constrained"

dataProduction = rbind(data.free, data.click)

dataProduction$subjective.vs.color = dataProduction$ADJ1OrColorFirst.Transformed
dataProduction$objective.vs.color = dataProduction$ADJ2OrColorFirst.Transformed


agr = dataProduction %>%
  group_by(section) %>%
  summarise(Mean = mean(subjective.vs.color, na.rm=TRUE), CILow = ci.low.grouped(dataProduction$subjective.vs.color, dataProduction$workerid, (1:length(dataProduction$subjective.vs.color))), CIHigh = ci.high.grouped(dataProduction$subjective.vs.color, dataProduction$workerid, (1:length(dataProduction$subjective.vs.color))))
agr$alien = "subjective"

agr2 = dataProduction %>%
  group_by(section) %>%
  summarise(Mean = mean(objective.vs.color, na.rm=TRUE), CILow = ci.low.grouped(dataProduction$objective.vs.color, dataProduction$workerid, (1:length(dataProduction$objective.vs.color))), CIHigh = ci.high.grouped(dataProduction$objective.vs.color, dataProduction$workerid, (1:length(dataProduction$objective.vs.color))))
agr2$alien = "objective"



#agr = dataProduction %>%
#  group_by(section) %>%
#  summarise(Mean = mean(subjective.vs.color, na.rm=TRUE), CILow = ci.low(subjective.vs.color), CIHigh = ci.high(subjective.vs.color))
#agr$alien = "subjective"
#
#agr2 = dataProduction %>%
#  group_by(section) %>%
#  summarise(Mean = mean(objective.vs.color, na.rm=TRUE), CILow = ci.low(objective.vs.color), CIHigh = ci.high(objective.vs.color))
#agr2$alien = "objective"

agr = rbind(agr, agr2)

dodge = position_dodge(.9)

pdf('plots/production.pdf')
ggplot(agr, aes(x=alien, y=Mean)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~section) +
  ylab('Alien Adjective before Color') +
  xlab('Type of Alien Adjective')
dev.off()


#aggregate(data3["response"], by=c(data3["subjectiveFirst"]), mean)



