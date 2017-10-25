


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

for(i in (2:5)) {
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


# The prediction is that the effect of subjectiveFirst is positive
summary(lmer(response ~ subjectiveFirst.Centered*inContext.Centered + preference1 + preference2 + (1|workerid), data=data7))


###########################################
# ANALYSIS II: items that contain exactly one alien word
###########################################
data2 = data[data$a != 0,]
data2 = centerColumn(data2, "condition")
data2$alienWordIsFirst = data2$a

data2$responseAlienFirst = (data2$alienWordIsFirst == 1) * data2$response + (data2$alienWordIsFirst == -1) * (1-data2$response)

library(tidyverse)


orderNorm = read.csv("../../35-artificial/results/alien-order-norm.tsv")
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



#########################################################################################
# ANALYSIS III: ANALYZING PRODUCTION DATA

oNormA1 = orderNorm %>% rename(adjective1 = predicate, preferenceA1 = response)
oNormA2 = orderNorm %>% rename(adjective2 = predicate, preferenceA2 = response)
oNormA2$preferenceA2 = 1-oNormA2$preferenceA2
data = merge(data, oNormA1, by=c("adjective1"))
data = merge(data, oNormA2, by=c("adjective2"))







data.free = data[data$slide_number > 80,]

data.click = data[data$slide_number < 80,]

data.free$ADJ2OrADJ1First.Transformed = ifelse(data.free$ADJ2OrADJ1First == "Q_ADJ2_ADJ1", 1, ifelse(data.free$ADJ2OrADJ1First == "Q_ADJ1_ADJ2", 0, NA))
data.free$ADJ2OrColorFirst.Transformed = ifelse(data.free$ADJ2OrColorFirst == "R_ADJ2_COLOR", 1, ifelse(data.free$ADJ2OrColorFirst == "R_COLOR_ADJ2", 0, NA))
data.free$ADJ1OrColorFirst.Transformed = ifelse(data.free$ADJ1OrColorFirst == "S_ADJ1_COLOR", 1, ifelse(data.free$ADJ1OrColorFirst == "S_COLOR_ADJ1", 0, NA))

summary(glm(ADJ2OrColorFirst.Transformed ~ adjective1, family="binomial", data=data.free))
summary(glm(ADJ1OrColorFirst.Transformed ~ adjective1, family="binomial", data=data.free))
summary(glm(ADJ2OrADJ1First.Transformed ~ adjective1, family="binomial", data=data.free))


summary(glm(ADJ2OrColorFirst.Transformed ~ preferenceA1 + preferenceA2, family="binomial", data=data.free))
summary(glm(ADJ1OrColorFirst.Transformed ~ preferenceA1 + preferenceA2, family="binomial", data=data.free))


summary(glmer(ADJ2OrColorFirst.Transformed ~ preferenceA1 + preferenceA2 + (1|workerid), family="binomial", data=data.free))
summary(glmer(ADJ1OrColorFirst.Transformed ~ preferenceA1 + preferenceA2 + (1|workerid), family="binomial", data=data.free))
# this one has one sample per participant, therefore no random effect
summary(glm(ADJ2OrADJ1First.Transformed ~ preferenceA1 + preferenceA2, family="binomial", data=data.free))
# the intercept is insignificant, but preferenceA1 is significant






########################

data.click$ADJ2OrADJ1First.Transformed = ifelse(data.click$ADJ2OrADJ1First == "Q_ADJ2_ADJ1", 1, ifelse(data.click$ADJ2OrADJ1First == "Q_ADJ1_ADJ2", 0, NA))
data.click$ADJ2OrColorFirst.Transformed = ifelse(data.click$ADJ2OrColorFirst == "R_ADJ2_COLOR", 1, ifelse(data.click$ADJ2OrColorFirst == "R_COLOR_ADJ2", 0, NA))
data.click$ADJ1OrColorFirst.Transformed = ifelse(data.click$ADJ1OrColorFirst == "S_ADJ1_COLOR", 1, ifelse(data.click$ADJ1OrColorFirst == "S_COLOR_ADJ1", 0, NA))

summary(glm(ADJ2OrColorFirst.Transformed ~ adjective1, family="binomial", data=data.click))
summary(glm(ADJ1OrColorFirst.Transformed ~ adjective1, family="binomial", data=data.click))
summary(glm(ADJ2OrADJ1First.Transformed ~ adjective1, family="binomial", data=data.click))

summary(glmer(ADJ2OrColorFirst.Transformed ~ preferenceA1 + preferenceA2 + (1|workerid), family="binomial", data=data.click))
summary(glmer(ADJ1OrColorFirst.Transformed ~ preferenceA1 + preferenceA2 + (1|workerid), family="binomial", data=data.click))
# this one has one sample per participant, therefore no random effect
summary(glm(ADJ2OrADJ1First.Transformed ~ preferenceA1 + preferenceA2, family="binomial", data=data.click))
# intercept and fixed effects are all insignificant

#data$ADJ1_ADJ2 = ifelse(data$ADJ2OrADJ1First == "Q_ADJ1_ADJ2", 1, ifelse(data$ADJ2OrADJ1First == "Q_ADJ2_ADJ1", -1, 0))



data.free$section = "free"
data.click$section = "constrained"

dataProduction = rbind(data.free, data.click)

##########################################################################
# two alien adjectives

dataProduction = centerColumn(dataProduction, "free")

summary(glm(ADJ2OrADJ1First.Transformed ~ free + preferenceA1 + preferenceA2, family="binomial", data=dataProduction))
# nothing is significant

###########################################################################
# compare ADJ1OrColorFirst.Transformed with ADJ2OrColorFirst.Transformed.

# which alien word?
dataProduction$alienVersusColor = ifelse(!is.na(dataProduction$ADJ1OrColorFirst.Transformed), 1, ifelse(!is.na(dataProduction$ADJ2OrColorFirst.Transformed), 2, NA))
# where does it stand w.r.t. color?
dataProduction$alienOrColorFirst = ifelse(!is.na(dataProduction$ADJ1OrColorFirst.Transformed), dataProduction$ADJ1OrColorFirst.Transformed, ifelse(!is.na(dataProduction$ADJ2OrColorFirst.Transformed), dataProduction$ADJ2OrColorFirst.Transformed, NA))

# A problem in this analysis is that the two datasets overlap. Therefore, remove overlapping points
dataProduction$alienIsUnique = ifelse(!is.na(dataProduction$ADJ1OrColorFirst.Transformed) & !is.na(dataProduction$ADJ2OrColorFirst.Transformed), NA, 0)
dataProduction$alienOrColorFirst = dataProduction$alienOrColorFirst + dataProduction$alienIsUnique

dataProduction$free = (dataProduction$section == "free")


dataProduction = centerColumn(dataProduction, "alienVersusColor")
dataProduction = centerColumn(dataProduction, "alienOrColorFirst")

summary(glmer(alienOrColorFirst ~ alienVersusColor.Centered*free.Centered + preferenceA1*alienVersusColor.Centered + preferenceA2*alienVersusColor.Centered + (1|workerid), data=dataProduction, family="binomial"))
#alienVersusColor.Centered                1.56447    0.76205   2.053   0.0401 # means the objective adjective is better before colors than the subjective adjective (at least numerically)
# free.Centered                           -0.86102    0.13798  -6.240 4.37e-10
# the preferences and their interactions are not significant
#################################################################################

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



