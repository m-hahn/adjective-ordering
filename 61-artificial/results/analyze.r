source('helpers.R')
library(lme4)
library(ggplot2)

# Read trial and subjects data

readData = function(path = "..", upTo) {
    data = read.csv(paste(path,"/Submiterator-master/order-preference-trials-postprocessed.tsv",sep=""), sep="\t")
    dataS = read.csv(paste(path,"/Submiterator-master/order-preference-subject_information.tsv",sep=""), sep="\t")
    
    if(upTo > 1) {
       for(i in c(2:upTo)) {
         dataNew = read.csv(paste(path, "/Submiterator-master/order-preference-",i,"-trials-postprocessed.tsv",sep=""), sep="\t")
         dataNew$workerid = as.numeric(dataNew$workerid) + i*10
         data = rbind(data, dataNew)
       
         dataSNew = read.csv(paste(path, "/Submiterator-master/order-preference-",i,"-subject_information.tsv", sep=""), sep="\t")
         dataSNew$workerid = as.numeric(dataSNew$workerid) + i*10
         dataS = rbind(dataS, dataSNew)
       }
    }

    return(list(data, dataS))
}

datasets = readData("..", 6)
data = datasets[[1]]
dataS = datasets[[2]]

data$part = 61
dataS$part = 61

###############
offset = max(dataS$workerid) + 10
datasets = readData("../../51-artificial", 6)
data51 = datasets[[1]]
dataS51 = datasets[[2]]
data51$part = 51
dataS51$part = 51
data51$workerid = data51$workerid + offset
dataS51$workerid = dataS51$workerid + offset
data = rbind(data, data51)
dataS = rbind(dataS, dataS51)
################
offset = max(dataS$workerid) + 10
datasets = readData("../../41-artificial", 10)
data41 = datasets[[1]]
dataS41 = datasets[[2]]
data41$part = 41
dataS41$part = 41
data41$workerid = data41$workerid + offset
dataS41$workerid = dataS41$workerid + offset
dataS41$context_first = 0
dataS41$tutorial = "osso"
data = rbind(data, data41)
dataS = rbind(dataS, dataS41)
data$iteration = 0
################
offset = max(dataS$workerid) + 10
datasets = readData("../../53-artificial", 7)
data53 = datasets[[1]]
dataS53 = datasets[[2]]
data53$part = 53
dataS53$part = 53
data53$workerid = data53$workerid + offset
dataS53$workerid = dataS53$workerid + offset
dataS53$context_first = 0
data53$relevant_adjective  = NA
data53$text = NA
data = rbind(data, data53)
dataS = rbind(dataS, dataS53)
################
offset = max(dataS$workerid) + 10
datasets = readData("../../54-artificial", 5)
data54 = datasets[[1]]
dataS54 = datasets[[2]]
data54$part = 54
dataS54$part = 54
data54$iteration = 0
data54$workerid = data54$workerid + offset
dataS54$workerid = dataS54$workerid + offset
data = rbind(data, data54)
dataS = rbind(dataS, dataS54)
################
offset = max(dataS$workerid) + 10
datasets = readData("../../55-artificial", 4)
data55 = datasets[[1]]
dataS55 = datasets[[2]]
data55$part = 55
dataS55$part = 55
data55$iteration = 0
data55$workerid = data55$workerid + offset
dataS55$workerid = dataS55$workerid + offset
data = rbind(data, data55)
dataS = rbind(dataS, dataS55)
################
offset = max(dataS$workerid) + 10
datasets = readData("../../56-artificial", 8)
data56 = datasets[[1]]
dataS56 = datasets[[2]]
data56$part = 56
dataS56$part = 56
data56$iteration = 0
data56$workerid = data56$workerid + offset
dataS56$workerid = dataS56$workerid + offset
data = rbind(data, data56)
dataS = rbind(dataS, dataS56)
################
offset = max(dataS$workerid) + 10
datasets = readData("../../57-artificial", 7)
data57 = datasets[[1]]
dataS57 = datasets[[2]]
data57$part = 57
dataS57$part = 57
data57$iteration = 0
dataS57$context_first = 0
dataS57$tutorial = "osso"
data57$workerid = data57$workerid + offset
dataS57$workerid = dataS57$workerid + offset
data = rbind(data, data57)
dataS = rbind(dataS, dataS57)
################
offset = max(dataS$workerid) + 10
datasets = readData("../../58-artificial", 3)
data58 = datasets[[1]]
dataS58 = datasets[[2]]
data58$part = 58
dataS58$part = 58
data58$iteration = 0
dataS58$context_first = 0
dataS58$tutorial = "osso"
data58$workerid = data58$workerid + offset
dataS58$workerid = dataS58$workerid + offset
data = rbind(data, data58)
dataS = rbind(dataS, dataS58)
################
offset = max(dataS$workerid) + 10
datasets = readData("../../59-artificial", 5)
data59 = datasets[[1]]
dataS59 = datasets[[2]]
data59$part = 59
dataS59$part = 59
data59$iteration = 0
dataS59$context_first = 0
dataS59$tutorial = "osso"
data59$workerid = data59$workerid + offset
dataS59$workerid = dataS59$workerid + offset
data = rbind(data, data59)
dataS = rbind(dataS, dataS59)
################
offset = max(dataS$workerid) + 10
datasets = readData("../../62-artificial", 4)
data62 = datasets[[1]]
dataS62 = datasets[[2]]
data62$part = 62
dataS62$part = 62
data62$iteration = 0
dataS62$context_first = 0
dataS62$tutorial = "osso"
data62$workerid = data62$workerid + offset
dataS62$workerid = dataS62$workerid + offset
data = rbind(data, data62)
dataS = rbind(dataS, dataS62)
################
offset = max(dataS$workerid) + 10
datasets = readData("../../63-artificial", 3)
data63 = datasets[[1]]
dataS63 = datasets[[2]]
data63$part = 63
dataS63$part = 63
data63$iteration = 0
dataS63$context_first = 0
dataS63$tutorial = "osso"
data63$workerid = data63$workerid + offset
dataS63$workerid = dataS63$workerid + offset
data = rbind(data, data63)
dataS = rbind(dataS, dataS63)
################
offset = max(dataS$workerid) + 10
datasets = readData("../../64-artificial", 3)
data64 = datasets[[1]]
dataS64 = datasets[[2]]
data64$part = 64
dataS64$part = 64
data64$iteration = 0
dataS64$context_first = 0
dataS64$tutorial = "osso"
data64$workerid = data64$workerid + offset
dataS64$workerid = dataS64$workerid + offset
data = rbind(data, data64)
dataS = rbind(dataS, dataS64)
################
offset = max(dataS$workerid) + 10
datasets = readData("../../65-artificial", 5)
data65 = datasets[[1]]
dataS65 = datasets[[2]]
data65$part = 65
dataS65$part = 65
data65$iteration = 0
dataS65$context_first = 0
#dataS65$tutorial = "osso" # randomized tutorial
data65$workerid = data65$workerid + offset
dataS65$workerid = dataS65$workerid + offset
data = rbind(data, data65)
dataS = rbind(dataS, dataS65)
################
offset = max(dataS$workerid) + 10
datasets = readData("../../67-artificial", 8)
data67 = datasets[[1]]
dataS67 = datasets[[2]]
data67$part = 67
dataS67$part = 67
data67$iteration = 0
dataS67$context_first = 0
#dataS67$tutorial = "osso" # randomized tutorial
data67$workerid = data67$workerid + offset
dataS67$workerid = dataS67$workerid + offset
data = rbind(data, data67)
dataS = rbind(dataS, dataS67)

dataS$moreInformative = "neither"

################
offset = max(dataS$workerid) + 10
datasets = readData("../../69-artificial", 3)
data69 = datasets[[1]]
dataS69 = datasets[[2]]
data69$part = 69
dataS69$part = 69
data69$iteration = 0
dataS69$context_first = 0
dataS69$tutorial = "osso" 
data69$workerid = data69$workerid + offset
dataS69$workerid = dataS69$workerid + offset
data = rbind(data, data69)
dataS = rbind(dataS, dataS69)







########################
library(tidyverse)
library(dplyr)
library(tidyr)
dataS = dataS %>% mutate(instructions = ifelse(part %in% c(41, 53, 55, 56, 57,58,59,61, 62, 63, 64, 65, 66, 67, 68, 69), -1, 1))
dataS = dataS %>% mutate(sentence_type = ifelse(part %in% c(41, 57,58,61, 62, 63, 64, 65, 66, 67, 68, 69), -1, ifelse(part %in% c(51, 54, 55, 56, 59), 1, 0)))
# this is not fully correct, a few times old sentences are mislabeled as new

# rename some columns for clarity
dataS = dataS %>% rename(subjective_adjective = adjective1, objective_adjective = adjective2)

# Exclude workers who did not do well on the comprehension task
data$correctQuiz = (data$correct_response == data$quiz_response)
correctByWorker = aggregate(data["correctQuiz"], by=c(data["workerid"]), mean, na.rm=TRUE)
dataS = merge(dataS, correctByWorker)
dataS = dataS[dataS$correctQuiz > 0.85,]

dataS$osso = (dataS$tutorial == "osso")
data$osso = (data$tutorial == "osso")

summary(glmer(correctQuiz


########################################################
# look at whether the manipulation worked
subjAgr = aggregate(c(data["adj1_disagreement"], data["adj2_disagreement"], data["adj1_subj"], data["adj2_subj"]), by=c(data["workerid"]), mean, na.rm=TRUE)
subjAgr$disagrDiff = subjAgr$adj1_disagreement - subjAgr$adj2_disagreement
subjAgr$subjDiff = subjAgr$adj1_subj - subjAgr$adj2_subj
data$adj1_subj = NULL
data$adj2_subj = NULL
data$adj1_disagreement = NULL
data$adj2_disagreement = NULL
dataS = merge(dataS, subjAgr, by=c("workerid"))
# Merge trial and subject data
data = merge(data, dataS, by=c("workerid"))
######################################################
######################################################
######################################################
# PART A: Analyze order ratings
######################################################
######################################################
# code which trials have alien adjectives in which position
# Note:
# - predicate1, predicate2 are the two adjectives in the rating trials
# - subjective_adjective, objective_adjective indicate the adjectives assigned to the worker
data$a1 = !(data$predicate1 %in% c("big", "small", "blue", "red", "green")) # first adjective is alien
data$a2 = !(data$predicate2 %in% c("big", "small", "blue", "red", "green")) # second adjective is alien

# 1: predicate1 is alien, predicate2 is not
# -1: predicate2 is alien, predicate1 is not
# 0: both adjectives are alien or both adjectives are English
data$a = data$a1 - data$a2
data$sequence = ifelse(data$a == 1, "alien-english", ifelse(data$a == -1, "english-alien", ifelse(data$a1, "alien-alien","english-english")))

dataAdj = data[,c('workerid','subjective_adjective', 'objective_adjective')]
dataAdj = subset(dataAdj, !duplicated(dataAdj$workerid))

data$subjective_adjective = NULL
data$objective_adjective = NULL

# TODO what's the point of this?
data = merge(data, dataAdj, by=c("workerid"))

# does the trial contain an alien subjective adjective?
data$containsSubjectiveAdjective = ((as.character(data$predicate1) == as.character(data$subjective_adjective)) | (as.character(data$predicate2) == as.character(data$subjective_adjective)))



# TODO for now, removed these, since only some adjectives appeared in 35/36
# read order ratings (aggregated by individual adjectives) from norming study as a control predictor
#orderNorm = read.csv("../../45-artificial/results/alien-order-norm.tsv")
#oNorm1 = orderNorm %>% rename(predicate1 = predicate, preference1 = response)
#oNorm2 = orderNorm %>% rename(predicate2 = predicate, preference2 = response)
#oNorm2$preference2 = 1-oNorm2$preference2
#data = merge(data, oNorm1, by=c("predicate1"))
#data = merge(data, oNorm2, by=c("predicate2"))

#posNorm = read.csv("../../46-artificial/results/pos-ratings.tsv")
#oNorm1 = posNorm %>% rename(predicate1 = predicate, adjective_intercept1 = adjective_intercept, noun_intercept1 = noun_intercept, verb_intercept1 = verb_intercept )
#oNorm2 = posNorm %>% rename(predicate2 = predicate, adjective_intercept2 = adjective_intercept, noun_intercept2 = noun_intercept, verb_intercept2 = verb_intercept )
##oNorm2$preference2 = 1-oNorm2$preference2
#data = merge(data, oNorm1, by=c("predicate1"), all=TRUE)
#data = merge(data, oNorm2, by=c("predicate2"), all=TRUE)

library(stringr)

data$preference1 = 0
data$preference2 = 0


######################################
# Count production frequencies

data$adj1OccursProduction = str_detect(as.character(data$ADJ2OrADJ1First), "ADJ1")
data$adj2OccursProduction = str_detect(as.character(data$ADJ2OrADJ1First), "ADJ2")

alienCounts = aggregate(c(data["adj1OccursProduction"], data["adj2OccursProduction"]), by=c(data["workerid"]), mean, na.rm=TRUE)
pdf('plots/subjAdjProductionHistogram.pdf')
hist(alienCounts$adj1OccursProduction)
dev.off()

pdf('plots/objAdjProductionHistogram.pdf')
hist(alienCounts$adj2OccursProduction)
dev.off()

pdf('plots/ProductionDiffsHistogram.pdf')
hist(alienCounts$adj1OccursProduction-alienCounts$adj2OccursProduction)
dev.off()

pdf('plots/ProductionLogDiffsHistogram.pdf')
hist(log(alienCounts$adj1OccursProduction+1)-log(alienCounts$adj2OccursProduction+1))
dev.off()





dataS = merge(dataS, alienCounts, by=c("workerid"))

data = merge(data, alienCounts %>% rename(adj1FreqProd = adj1OccursProduction, adj2FreqProd = adj2OccursProduction), by=c("workerid"))


#[1] <NA>                  Q_ADJ1_ADJ2           Q_ADJ2_ADJ1          
#[4] Q_ADJ2                Q_ADJ1                Q_                   
#[7] Q_ADJ2_ADJ2           Q_ADJ1_ADJ1_ADJ2      Q_ADJ1_ADJ2_ADJ1_ADJ2

data$prodDiff = data$adj1FreqProd - data$adj2FreqProd
data$logProdDiff = log(data$adj1FreqProd+1) - log(data$adj2FreqProd+1)





#######################################
#######################################
# ANALYSIS I: analyze items where both adjectives are alien words
#######################################

dataAA = data[!is.na(data$predicate1) & data$a1 + data$a2 == 2,]

dataAA$subjectiveFirst = (as.character(dataAA$predicate1) == as.character(dataAA$subjective_adjective))

# does the trial belong to the block having contexts?
dataAA$inContext = !is.na(dataAA$relevant_adjective)

dataAA = centerColumn(dataAA, "inContext")
dataAA = centerColumn(dataAA, "subjectiveFirst")

# Analysis
# The prediction is that the effect of subjectiveFirst is positive.
m = lmer(response ~ subjectiveFirst + preference1 + preference2 + (subjectiveFirst|workerid) + (1|workerid) + (1|predicate1) + (1|predicate2), data=dataAA)
summary(m)

dataAA = centerColumn(dataAA, "subjDiff")
dataAA = centerColumn(dataAA, "disagrDiff")
dataAA = centerColumn(dataAA, "context_first")

m = lmer(response ~ subjectiveFirst.Centered*subjDiff.Centered +(subjectiveFirst|workerid) + (1|workerid) + (1|predicate1) + (1|predicate2), data=dataAA)
summary(m)

m = lmer(response ~ subjectiveFirst.Centered*subjDiff.Centered + (1|predicate1) + (1|predicate2), data=dataAA)
summary(m)
# there is an effect here in the predicted direction ...

dataAA = centerColumn(dataAA, "prodDiff")

m = lmer(response ~ subjectiveFirst.Centered*prodDiff.Centered + (1|workerid) + (1|predicate1) + (1|predicate2), data=dataAA)
summary(m)


library('tidyverse')


# Duplicate the dataset so that each item appears in the original order and in the inverted order, with "1 minus original response" as response
dataAOpposite = dataAA %>% rename(pred1 = predicate2, pred2 = predicate1) %>% rename(predicate1 = pred1, predicate2 = pred2)
dataAOpposite$response = 1-dataAOpposite$response
dataA2 = rbind(dataAA, dataAOpposite)
# is the first adjective the subjective (alien) adjective?
dataA2$firstIsSubjective = (as.character(dataA2$predicate1) == as.character(dataA2$subjective_adjective))

# Per-Adjective-Pair Visualization 
agr = dataA2 %>%
  group_by(predicate1, predicate2, firstIsSubjective) %>%
  summarise(Mean = mean(response), CILow = ci.low(response), CIHigh = ci.high(response))
dodge = position_dodge(.9)


plot = ggplot(agr, aes(x=predicate2, y=Mean, color=firstIsSubjective)) + 
   geom_bar(stat="identity",position=dodge) +
   geom_errorbar(aes(ymin=Mean-CILow, ymax=Mean+CIHigh), position=dodge,width=.25) +
   facet_wrap(~predicate1)
ggsave('plots/alien_pairs_merged.pdf', plot=plot) 

###############
dataAA$subjectiveFirst.Label = (ifelse(dataAA$subjectiveFirst, "Subjective First", "Objective First"))

# plot by Manipulation effect strength
dataAA$ManipulationEffect = ifelse(dataAA$subjDiff < 0.0, "0 Opposite", ifelse(dataAA$subjDiff < 0.4, "1 Small", "2 Big"))
#agr = dataAA %>%
#  group_by(ManipulationEffect, subjectiveFirst.Label) %>%
#  summarise(Mean = mean(response), CILow = ci.low(response), CIHigh = ci.high(response))
dataAA$item = (1:nrow(dataAA))
agr = dataAA %>%
  group_by(ManipulationEffect, subjectiveFirst.Label) %>%
  summarise(Mean = mean(response), CILow = ci.low.grouped(response, workerid, item), CIHigh = ci.high.grouped(response, workerid, item))
dodge = position_dodge(.9)

pdf('plots/alien-pairs-order-ratings-by-manipulation-effect.pdf')
ggplot(agr, aes(x=subjectiveFirst.Label,y=Mean, fill=ManipulationEffect)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  ylab('Rating') +
  xlab('Ordering of Alien Adjectives')
dev.off()

agr = dataAA %>%
  group_by(moreInformative, subjectiveFirst.Label) %>%
  summarise(Mean = mean(response), CILow = ci.low.grouped(response, workerid, item), CIHigh = ci.high.grouped(response, workerid, item))
dodge = position_dodge(.9)

pdf('plots/alien-pairs-informativity.pdf')
ggplot(agr, aes(x=subjectiveFirst.Label,y=Mean, fill=moreInformative)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  ylab('Rating') +
  xlab('Ordering of Alien Adjectives')
dev.off()


dataAA$manipulationEffectFaultless = ifelse(dataAA$subjDiff < 0.0, "0 Opposite", ifelse(dataAA$subjDiff < 0.4, "1 Small", "2 Big"))
agr = dataAA %>%
  group_by(manipulationEffectFaultless, subjectiveFirst.Label) %>%
  summarise(Mean = mean(response), CILow = ci.low.grouped(response, workerid, item), CIHigh = ci.high.grouped(response, workerid, item))
dodge = position_dodge(.9)

pdf('plots/alien-pairs-order-ratings-by-manipulation-effect-faultless.pdf')
ggplot(agr, aes(x=subjectiveFirst.Label,y=Mean, fill=manipulationEffectFaultless)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  ylab('Rating') +
  xlab('Ordering of Alien Adjectives')
dev.off()


dataAA$item = (1:nrow(dataAA))
agr = dataAA %>%
  group_by(subjectiveFirst.Label) %>%
  summarise(Mean = mean(response), CILow = ci.low.grouped(response, workerid, item), CIHigh = ci.high.grouped(response, workerid, item))
dodge = position_dodge(.9)

pdf('plots/alien-pairs-order-ratings.pdf')
ggplot(agr, aes(x=subjectiveFirst.Label,y=Mean)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  ylab("Order Rating") +
  xlab("Order of Adjectives") + theme(panel.background = element_blank(), axis.text=element_text(size=18, colour="black"), axis.title=element_text(size=18, colour="black"))
dev.off()





###########################################
###########################################
# ANALYSIS II: ratings items that contain exactly one alien word
###########################################

data2 = data[data$a != 0,] # select trials where exactly one word is an alien adjective
data2 = centerColumn(data2, "containsSubjectiveAdjective")
data2$alienWordIsFirst = data2$a # is the first adjective the alien one?

# for each trial, compute the response for the version where the alien adjective comes first
data2$responseAlienFirst = (data2$alienWordIsFirst == 1) * data2$response + (data2$alienWordIsFirst == -1) * (1-data2$response)

data2$preferenceAlien = ifelse(data2$alienWordIsFirst == 1, data2$preference1, data2$preference2)
data2$preferenceEnglish = ifelse(data2$alienWordIsFirst == 1, data2$preference2, data2$preference1)

#data2$adjective_intercept = ifelse(data2$alienWordIsFirst == 1, data2$adjective_intercept1, data2$adjective_intercept2)
#data2$noun_intercept = ifelse(data2$alienWordIsFirst == 1, data2$noun_intercept1, data2$noun_intercept2)
#data2$verb_intercept = ifelse(data2$alienWordIsFirst == 1, data2$verb_intercept1, data2$verb_intercept2)


library(tidyverse)


# select the alien adjective
data2$nonAlienAdjective = ifelse(data2$a1, as.character(data2$predicate2), as.character(data2$predicate1))
data2$nonAlienAdjectiveIsColor = (data2$nonAlienAdjective %in% c("red", "green", "blue"))
data2$alienAdjective = ifelse(data2$a1, as.character(data2$predicate1), as.character(data2$predicate2))

data5 = rbind(data2)
# does the trial occur in the In-Context block, or in the other ratings block?
data5$inContext = !is.na(data5$relevant_adjective)
data5 = centerColumn(data5, "inContext")
data5 = centerColumn(data5, "alienWordIsFirst")
data5 = centerColumn(data5, "nonAlienAdjectiveIsColor")
data5 = centerColumn(data5, "subjDiff")


#data5 = centerColumn(data5, "adjective_intercept")
#data5 = centerColumn(data5, "noun_intercept")
#data5 = centerColumn(data5, "verb_intercept")

data5 = centerColumn(data5, "part.x")
data5 = centerColumn(data5, "context_first")

data5 = centerColumn(data5, "sentence_type")

# MAIN ANALYSIS
# Analysis: predict rating for `alien first' based on containsSubjectiveAdjective
# The prediction is that the effect of containsSubjectiveAdjective on responseAlienFirst is positive
# (i.e., ratings for alien-first increase when the alien adjective is subjective)
# Unlike Experiment 30, this effect is not shown here.
m = lmer(responseAlienFirst ~ nonAlienAdjectiveIsColor.Centered*inContext.Centered*containsSubjectiveAdjective.Centered + preferenceAlien + preferenceEnglish + (1|workerid), data=data5)
summary(m)

m = lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered + preferenceAlien + preferenceEnglish + (1|workerid), data=data5)
summary(m)



m = lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered*subjDiff.Centered + (1|workerid) + (1|predicate1) + (1|predicate2), data=data5)
summary(m)


data5$moreInformativeSubj = (data5$moreInformative == "subj")
data5 = centerColumn(data5, "moreInformativeSubj")
m = lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered*moreInformativeSubj.Centered + preferenceAlien + preferenceEnglish + (1|workerid), data=data5)
summary(m)




data5 = centerColumn(data5, "iteration")

m = lmer(responseAlienFirst ~ nonAlienAdjectiveIsColor.Centered*inContext.Centered*containsSubjectiveAdjective.Centered*context_first.Centered*iteration.Centered + preferenceAlien + preferenceEnglish + (containsSubjectiveAdjective.Centered|workerid) + (1|workerid) + (1|predicate1) + (1|predicate2), data=data5)
#                                                            Std. Error t value
#(Intercept)                                                   0.016870  12.858
#containsSubjectiveAdjective.Centered                          0.005791   3.249
#context_first.Centered                                        0.016331   1.319
#iteration.Centered                                            0.005583  -1.889
#containsSubjectiveAdjective.Centered:context_first.Centered   0.005748  -2.088
#containsSubjectiveAdjective.Centered:iteration.Centered       0.004796  -1.515


# restrict analsis to those data points that use new sentences, or are not causally influenced by any sentence:
# data5$manip = ifelse((data5$inContext == FALSE | data5$sentence_type > -1) & data5$context_first == 0, data5$containsSubjectiveAdjective.Centered, 0)
#m = lmer(responseAlienFirst ~ manip + (1|workerid) + (1|predicate1) + (1|predicate2), data=data5)
# t > 4-> very promising
# data6 = data5[data5$manip != 0,]
# data6 = centerColumn(data6, "manip")
#m = lmer(responseAlienFirst ~ manip.Centered*nonAlienAdjectiveIsColor.Centered + (manip.Centered|alienAdjective) + (1|workerid) + (1|alienAdjective), data=data6)

createUniqueItemIDs = function(data, columnName) {
   newName = (paste(columnName,"Renumbered",sep="."))
   data[,newName] = as.integer(factor(data[,columnName]))
   return (data)
}

data6.Complete = data6[complete.cases(data6[,c("containsSubjectiveAdjective.Centered","nonAlienAdjectiveIsColor.Centered","inContext.Centered","workerid","alienAdjective","responseAlienFirst")]),]
data6.Complete$responseAlienFirst = (data6.Complete$responseAlienFirst * (nrow(data6.Complete)-1) + 0.5) / nrow(data6.Complete)

data6.Complete = createUniqueItemIDs(data6.Complete, "workerid")
data6.Complete = createUniqueItemIDs(data6.Complete, "alienAdjective")
data6.Complete = centerColumn(data6.Complete,"containsSubjectiveAdjective")
data6.Complete = centerColumn(data6.Complete,"nonAlienAdjectiveIsColor")
data6.Complete = centerColumn(data6.Complete,"inContext")
stanDat <- list(containsSubjectiveAdjective = data6.Complete$containsSubjectiveAdjective.Centered , nonAlienAdjectiveIsColor = data6.Complete$nonAlienAdjectiveIsColor.Centered , inContext = data6.Complete$inContext.Centered , responseAlienFirst = data6.Complete$responseAlienFirst,workerid = data6.Complete$workerid.Renumbered , alienAdjective = data6.Complete$alienAdjective.Renumbered , N = nrow(data6.Complete) , M = max(data6.Complete$alienAdjective.Renumbered) , L = max(data6.Complete$workerid.Renumbered))
library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
fixMCMC <- stan(file = "model-alien-english-sigma-new.stan", data = stanDat, iter = 2000, warmup=1000,chains = 2, control=list(adapt_delta=0.7) )

slopes = sapply(c(1:59), function(x) {quantile(fittedModel$for_alienAdjective[,2,x]+fittedModel$beta1, 0.5)[[1]]})
intercepts = sapply(c(1:59), function(x) {quantile(fittedModel$for_alienAdjective[,1,x]+fittedModel$alpha, 0.5)[[1]]})

renumbered = aggregate(data6.Complete["alienAdjective.Renumbered"], by=c(data6.Complete["alienAdjective"]), mean)

byAdj = data.frame(slopes=slopes, intercepts=intercepts, adjID = c(1:59))
byAdj = merge(byAdj, renumbered %>% rename(adjID = alienAdjective.Renumbered))
byAdj = byAdj[order(byAdj$slopes),]
write.csv(byAdj, file="beta-slopes-alienAdjectives.csv")

data5$contextAndOld = ifelse(data5$inContext, ifelse(data5$sentence_type == -1, -1, 1), 0)

#> aggregate(data$workerid, by=c(data["part.x"],sapply(data$text, substring,1,20),data["context_type"]), NROW)

data5 = centerColumn(data5, "prodDiff")
data5 = centerColumn(data5, "logProdDiff")

data5$subjMinusObjProdFreq.Centered = data5$prodDiff.Centered
data5$subjMinusObjProdLogFreq.Centered = data5$logProdDiff.Centered

m = lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered*prodDiff.Centered +  (1|workerid) + (1|predicate1) + (1|predicate2), data=data5)
summary(m)

m = lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered*logProdDiff.Centered +  (1|workerid) + (1|predicate1) + (1|predicate2), data=data5)
summary(m)


data5$osso = (data5$tutorial == "osso")
data5 = centerColumn(data5, "osso")

m = lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered*osso.Centered +  (1|workerid) + (1|predicate1) + (1|predicate2), data=data5)
summary(m)





# incorporate data from 46 (POS ratings)

#summary(lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered * adjective_intercept.Centered + (1|workerid), data=data5))
#summary(lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered * noun_intercept.Centered + (1|workerid), data=data5))
#summary(lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered * verb_intercept.Centered + (1|workerid), data=data5))

################## figure out power per participant, with `manip'
ts = c()
dataS2=unique(data6$workerid)
# positive rate: 0.42 at 60 participants, but of course a lot of data is lost compared to analyses not using manip, so this is very conservative
# get 0.8 positive rate at 150 participants
# get 0.88 positive rate at 220 participants

for(i in c(1:50)) {
   workers = sample(dataS2, 200)
   data7 = data5[data5$workerid %in% workers,]
   m = lmer(responseAlienFirst ~ manip + (1|workerid), data=data7)
   estimate = coef(m)$containsSubjectiveAdjective.Centered
   t = coef(summary(m))[2,3]
   ts = c(t,ts)
   cat(t,"\n")
}
mean(ts > 2)
mean(ts < -2)


################## figure out power per participant
ts = c()
dataS2=dataS
# positive rate: 0.26

#dataS2 = dataS[dataS$part %in% c(55,56),]
# positive rate: 0.4 (at 30 participants)

#dataS2 = dataS[dataS$tutorial != "osso" & dataS$context_first == 0,]
# positive rate: 0.26 (at 30 participants)

#dataS2 = dataS[dataS$tutorial == "osso" & dataS$context_first == 0,]
# positive rate: 0.70 (at 30 participants)
# this is highly correlated with things close to 41, like dataS$sentence_type == -1 (correlation 0.71)

#dataS2 = dataS[dataS$sentence_type == -1,]
# positive rate: 0.62 (at 30 participants)

#dataS2 = dataS[dataS$context_first == 0,]
# positive rate: 0.46 (at 30 participants)

dataS2 = dataS[dataS$context_first == 0 & dataS$sentence_type > -1,]
# positive rate: 0.22 (at 30 participants)

for(i in c(1:50)) {
   workers = sample(dataS2$workerid, 30)
   data7 = data5[data5$workerid %in% workers,]
#   data7 = data7[!data7$inContext,]
   m = lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered + (1|workerid), data=data7)
   estimate = coef(m)$containsSubjectiveAdjective.Centered
   t = coef(summary(m))[2,3]
   ts = c(t,ts)
   cat(t,"\n")
}
mean(ts > 2)
mean(ts < -2)



m = lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered + (containsSubjectiveAdjective.Centered|alienAdjective) + (1|alienAdjective) + (containsSubjectiveAdjective.Centered|workerid) + (1|workerid), data=data5)
slopes = coef(m)$alienAdjective
slopes$predicate = rownames(slopes)
posNorm = merge(posNorm, slopes, by=c("predicate"), all=TRUE)
write.csv(posNorm, file="pos-norms-slopes.csv")
write.csv(slopes, file="slopes.csv")




######################################
createUniqueItemIDs = function(data, columnName) {
   newName = (paste(columnName,"Renumbered",sep="."))
   data[,newName] = as.integer(factor(data[,columnName]))
   return (data)
}
data5 = createUniqueItemIDs(data5, "workerid")
m = lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered + (1|workerid.Renumbered) + (containsSubjectiveAdjective.Centered|workerid.Renumbered), data=data5)
bySubjectSlopes = (coef(m)$workerid.Renumbered)$containsSubjectiveAdjective.Centered

#a = frame()
# a$slopes = bySubjectSlopes
# a$workerid.Renumbered = (1:67)
# a = merge(data5, a, by=c("workerid.Renumbered"))
#
# slopesByAdjs = aggregate(a["slopes"], by=c(a["subjective_adjective"], a["objective_adjective"]), mean)
# slopesByAdjs[order(slopesByAdjs$slopes),]




# NOTE there is actually some interaction with subjectivity ratings:
m = lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered*adj1_subj.Centered + containsSubjectiveAdjective.Centered*adj2_subj.Centered + (1|workerid), data=data5)
m = lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered*adj1_disagreement.Centered + containsSubjectiveAdjective.Centered*adj2_disagreement.Centered + containsSubjectiveAdjective.Centered*adj1_subj.Centered + containsSubjectiveAdjective.Centered*adj2_subj.Centered + (1|workerid), data=data5)



################################################################################################
# do (mixed-effects) Beta regression: fits the response distribution much better, and seems to give same results

# make sure no response is at 0, 1
#data5$responseAlienFirst = (data5$responseAlienFirst * (nrow(data5)-1) + 0.5) / nrow(data5)
#
#data5.Complete = data5[complete.cases(data5[,c("containsSubjectiveAdjective.Centered","workerid","predicate1","predicate2","responseAlienFirst")]),]
#data5.Complete = createUniqueItemIDs(data5.Complete, "workerid")
#data5.Complete = createUniqueItemIDs(data5.Complete, "predicate1")
#data5.Complete = createUniqueItemIDs(data5.Complete, "predicate2")
#data5.Complete = centerColumn(data5.Complete,"containsSubjectiveAdjective")
#data5.Complete = centerColumn(data5.Complete,"responseAlienFirst")
#stanDat <- list(containsSubjectiveAdjective = data5.Complete$containsSubjectiveAdjective.Centered , responseAlienFirst = data5.Complete$responseAlienFirst,workerid = data5.Complete$workerid.Renumbered , adjective1 = data5.Complete$predicate1.Renumbered , adjective2 = data5.Complete$predicate2.Renumbered , N = nrow(data5.Complete) , M = max(data5.Complete$predicate1.Renumbered) , L = max(data5.Complete$workerid.Renumbered))
#library(rstan)
#rstan_options(auto_write = TRUE)
#options(mc.cores = parallel::detectCores())
#fixMCMC <- stan(file = "model-beta-alien-english.stan", data = stanDat, iter = 2000, warmup=1000,chains = 2, control=list(adapt_delta=0.7) )
#
#print(fixMCMC, pars=c("alpha", "beta1"), probs = c(0.05,  0.95), digits_summary=3)
#
#fittedModel = extract(fixMCMC)
#cat(paste("alpha",mean(fittedModel$alpha<0),mean(fittedModel$alpha>0),sep="\t"),sep="\n")
#cat(paste("beta1",mean(fittedModel$beta1<0),mean(fittedModel$beta1>0),sep="\t"),sep="\n")

################################################################################################





################ Further analysis
## integrate subjectivity and faultless disagreement scores for the two Alien adjectives, from the final questionnaire
#subjectivity1 = aggregate(data$adj1_subj, by=c(data["workerid"]), mean, na.rm=TRUE)  %>% rename(subjectivity1=x)
#subjectivity2 = aggregate(data$adj2_subj, by=c(data["workerid"]), mean, na.rm=TRUE)  %>% rename(subjectivity2=x)
#disagreement1 = aggregate(data$adj1_disagreement, by=c(data["workerid"]), mean, na.rm=TRUE)  %>% rename(disagreement1=x)
#disagreement2 = aggregate(data$adj2_disagreement, by=c(data["workerid"]), mean, na.rm=TRUE)  %>% rename(disagreement2=x)
#subjDis = Reduce(function(x, y) merge(x,y, by=c("workerid")), list(subjectivity1, subjectivity2, disagreement1, disagreement2))
#
#data5 = merge(data5, subjDis, by=c("workerid"))
#
#data5 = centerColumn(data5, "subjectivity1")
#data5 = centerColumn(data5, "subjectivity2")
#data5 = centerColumn(data5, "disagreement1")
#data5 = centerColumn(data5, "disagreement2")
#
#summary(lmer(responseAlienFirst ~ subjectivity2.Centered*containsSubjectiveAdjective.Centered + subjectivity1.Centered*containsSubjectiveAdjective.Centered + disagreement1.Centered*containsSubjectiveAdjective.Centered + disagreement2.Centered*containsSubjectiveAdjective.Centered + (1|workerid), data=data5))


###################
# Visualization, aggregated over all adjectives

data5$nonAlienAdjectiveIsColor.Label = ifelse(data5$nonAlienAdjectiveIsColor, "Color", "Size")
data5$inContext.Label = ifelse(data5$inContext, "In Context", "Out of Context")
data5$containsSubjectiveAdjective.Label = ifelse(data5$containsSubjectiveAdjective, "subjective", "objective")

data5$item = (1:nrow(data5))
agr = data5 %>%
  group_by(containsSubjectiveAdjective.Label, nonAlienAdjectiveIsColor.Label, inContext.Label) %>%
  summarise(Mean = mean(responseAlienFirst), CILow = ci.low.grouped(responseAlienFirst, workerid, item), CIHigh = ci.high.grouped(responseAlienFirst, workerid, item))
dodge = position_dodge(.9)

pdf('plots/order-ratings.pdf')
ggplot(agr, aes(x=containsSubjectiveAdjective.Label,y=Mean,fill=containsSubjectiveAdjective.Label)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~nonAlienAdjectiveIsColor.Label+inContext.Label)+
  ylab('Rating for Alien First') +
  xlab('Type of Alien Adjective')
dev.off()



agr = data5 %>%
#  filter(nonAlienAdjectiveIsColor) %>%
  group_by(containsSubjectiveAdjective.Label,nonAlienAdjectiveIsColor.Label) %>%
  summarise(Mean = mean(responseAlienFirst), CILow = ci.low(responseAlienFirst), CIHigh = ci.high(responseAlienFirst))
dodge = position_dodge(.9)

plot = ggplot(agr, aes(x=containsSubjectiveAdjective.Label,y=Mean)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~nonAlienAdjectiveIsColor.Label)+
  ylab('Rating for Alien First') +
  xlab('Type of Alien Adjective') + theme(panel.background = element_blank(), text = element_text(size=20))
pdf('plots/order-ratings-alien-english.pdf')
print(plot)
dev.off()







agr = data5 %>%
  group_by(containsSubjectiveAdjective.Label) %>%
  summarise(Mean = mean(responseAlienFirst), CILow = ci.low.grouped.1D(responseAlienFirst,workerid), CIHigh = ci.high.grouped.1D(responseAlienFirst,workerid))
dodge = position_dodge(.9)

plot = ggplot(agr, aes(x=containsSubjectiveAdjective.Label,y=Mean)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  ylab('Rating for Alien First') +
  xlab('Type of Alien Adjective') + theme(panel.background = element_blank(), text = element_text(size=20))
pdf('plots/order-ratings-summary.pdf')
print(plot)
dev.off()




agr = data5 %>%
  group_by(containsSubjectiveAdjective.Label, tutorial) %>%
  summarise(Mean = mean(responseAlienFirst), CILow = ci.low.grouped.1D(responseAlienFirst, workerid), CIHigh = ci.high.grouped.1D(responseAlienFirst, workerid))
dodge = position_dodge(.9)

plot = ggplot(agr, aes(x=containsSubjectiveAdjective.Label,y=Mean)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~tutorial)+
  ylab('Rating for Alien First') +
  xlab('Type of Alien Adjective') + theme(panel.background = element_blank(), text = element_text(size=20))
pdf('plots/order-ratings-summary-by-tutorial-order.pdf')
print(plot)
dev.off()



data5$context_first.Label = ifelse(data5$context_first == 1, "In-Context _first", "Out-of-Context _first")

agr = data5 %>%
  group_by(containsSubjectiveAdjective.Label, context_first.Label) %>%
  summarise(Mean = mean(responseAlienFirst), CILow = ci.low.grouped.1D(responseAlienFirst, workerid), CIHigh = ci.high.grouped.1D(responseAlienFirst, workerid))
dodge = position_dodge(.9)

plot = ggplot(agr, aes(x=containsSubjectiveAdjective.Label,y=Mean)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~context_first.Label)+
  ylab('Rating for Alien First') +
  xlab('Type of Alien Adjective') + theme(panel.background = element_blank(), text = element_text(size=20))
pdf('plots/order-ratings-summary-by-ratings-order.pdf')
print(plot)
dev.off()







agr = data5 %>%
  group_by(containsSubjectiveAdjective.Label) %>%
  summarise(Mean = mean(responseAlienFirst), CILow = ci.low.grouped.1D(responseAlienFirst,workerid), CIHigh = ci.high.grouped.1D(responseAlienFirst,workerid))
dodge = position_dodge(.9)

plot = ggplot(agr, aes(x=containsSubjectiveAdjective.Label,y=Mean)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  ylab('Rating for Alien First') +
  xlab('Type of Alien Adjective') + theme(panel.background = element_blank(), text = element_text(size=20))
pdf('plots/order-ratings-summary-by-workers.pdf')
print(plot)
dev.off()



# plot by effect strength of manipulation
data5$manipulationEffect = ifelse(data5$subjDiff < 0.0, "0 Opposite", ifelse(data5$subjDiff < 0.3, "1 Small", "2 Big"))
data5$item = (1:nrow(data5))
#agr = data5 %>%
#  group_by(manipulationEffect, containsSubjectiveAdjective.Label, nonAlienAdjectiveIsColor.Label) %>%
#  summarise(Mean = mean(responseAlienFirst), CILow = ci.low.grouped(responseAlienFirst, workerid, item), CIHigh = ci.high.grouped(responseAlienFirst, workerid, item))
agr = data5 %>%
  group_by(manipulationEffect, containsSubjectiveAdjective.Label, nonAlienAdjectiveIsColor.Label) %>%
  summarise(Mean = mean(responseAlienFirst), CILow = ci.low(responseAlienFirst), CIHigh = ci.high(responseAlienFirst))
dodge = position_dodge(.9)

pdf('plots/order-ratings-summary-by-manipulation-effect.pdf')
ggplot(agr, aes(x=containsSubjectiveAdjective.Label,y=Mean, fill=manipulationEffect)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~nonAlienAdjectiveIsColor.Label)+
  ylab('Rating for Alien First') +
  xlab('Type of Alien Adjective')
dev.off()




# plot by effect strength of manipulation
data5$manipulationEffect = ifelse(data5$subjDiff < 0.0, "0 Opposite", ifelse(data5$subjDiff < 0.4, "1 Small", "2 Big"))
data5$item = (1:nrow(data5))
agr = data5 %>%
  group_by(manipulationEffect, containsSubjectiveAdjective.Label, nonAlienAdjectiveIsColor.Label, inContext.Label) %>%
  summarise(Mean = mean(responseAlienFirst), CILow = ci.low.grouped(responseAlienFirst, workerid, item), CIHigh = ci.high.grouped(responseAlienFirst, workerid, item))
dodge = position_dodge(.9)

pdf('plots/order-ratings-by-manipulation-effect.pdf')
ggplot(agr, aes(x=containsSubjectiveAdjective.Label,y=Mean, fill=manipulationEffect)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~nonAlienAdjectiveIsColor.Label+inContext.Label)+
  ylab('Rating for Alien First') +
  xlab('Type of Alien Adjective')
dev.off()



data5$manipulationEffectFaultless = ifelse(data5$subjDiff < 0.0, "0 Opposite", ifelse(data5$subjDiff < 0.4, "1 Small", "2 Big"))
data5$item = (1:nrow(data5))
agr = data5 %>%
  group_by(manipulationEffectFaultless, containsSubjectiveAdjective.Label, nonAlienAdjectiveIsColor.Label, inContext.Label) %>%
  summarise(Mean = mean(responseAlienFirst), CILow = ci.low.grouped(responseAlienFirst, workerid, item), CIHigh = ci.high.grouped(responseAlienFirst, workerid, item))
dodge = position_dodge(.9)

pdf('plots/order-ratings-by-manipulation-effect-faultless.pdf')
ggplot(agr, aes(x=containsSubjectiveAdjective.Label,y=Mean, fill=manipulationEffectFaultless)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~nonAlienAdjectiveIsColor.Label+inContext.Label)+
  ylab('Rating for Alien First') +
  xlab('Type of Alien Adjective')
dev.off()

#############################################
# By-Adjective Visualization

dataOpposite = data5 %>% rename(pred1 = predicate2, pred2 = predicate1) %>% rename(predicate1 = pred1, predicate2 = pred2)
dataOpposite$response = 1-dataOpposite$response

data20 = rbind(data5, dataOpposite)

dataNA = data20[(data20$predicate2 %in% c("green","red","blue","small","big")),]

dataNA$alienIsSubjective = (as.character(dataNA$predicate1) == as.character(dataNA$subjective_adjective))

agr = dataNA %>%
  group_by(predicate1, predicate2, alienIsSubjective) %>%
  summarise(Mean = mean(response), CILow = ci.low(response), CIHigh = ci.high(response))
dodge = position_dodge(.9)


plot = ggplot(agr, aes(x=predicate2, y=Mean, color=alienIsSubjective)) + 
   geom_bar(stat="identity",position=dodge) +
   geom_errorbar(aes(ymin=Mean-CILow, ymax=Mean+CIHigh), position=dodge,width=.25) +
   facet_wrap(~predicate1)
ggsave('plots/alien_english_merged.pdf', plot=plot) 




##################################################
##################################################
##################################################
#### PART B: ANALYZING PRODUCTION
##################################################


data.free = data[data$slide_number > 80,]

data.click = data[data$slide_number < 80,]

data.free$ADJ2OrADJ1First.Transformed = ifelse(data.free$ADJ2OrADJ1First == "Q_ADJ2_ADJ1", 1, ifelse(data.free$ADJ2OrADJ1First == "Q_ADJ1_ADJ2", 0, NA))
data.free$ADJ2OrColorFirst.Transformed = ifelse(data.free$ADJ2OrColorFirst == "R_ADJ2_COLOR", 1, ifelse(data.free$ADJ2OrColorFirst == "R_COLOR_ADJ2", 0, NA))
data.free$ADJ1OrColorFirst.Transformed = ifelse(data.free$ADJ1OrColorFirst == "S_ADJ1_COLOR", 1, ifelse(data.free$ADJ1OrColorFirst == "S_COLOR_ADJ1", 0, NA))

#summary(glm(ADJ2OrColorFirst.Transformed ~ subjective_adjective, family="binomial", data=data.free))
#summary(glm(ADJ1OrColorFirst.Transformed ~ subjective_adjective, family="binomial", data=data.free))
summary(glm(ADJ2OrADJ1First.Transformed ~ subjective_adjective, family="binomial", data=data.free))

########################

data.click$ADJ2OrADJ1First.Transformed = ifelse(data.click$ADJ2OrADJ1First == "Q_ADJ2_ADJ1", 1, ifelse(data.click$ADJ2OrADJ1First == "Q_ADJ1_ADJ2", 0, NA))
data.click$ADJ2OrColorFirst.Transformed = ifelse(data.click$ADJ2OrColorFirst == "R_ADJ2_COLOR", 1, ifelse(data.click$ADJ2OrColorFirst == "R_COLOR_ADJ2", 0, NA))
data.click$ADJ1OrColorFirst.Transformed = ifelse(data.click$ADJ1OrColorFirst == "S_ADJ1_COLOR", 1, ifelse(data.click$ADJ1OrColorFirst == "S_COLOR_ADJ1", 0, NA))

#summary(glm(ADJ2OrColorFirst.Transformed ~ subjective_adjective, family="binomial", data=data.click))
#summary(glm(ADJ1OrColorFirst.Transformed ~ subjective_adjective, family="binomial", data=data.click))
summary(glm(ADJ2OrADJ1First.Transformed ~ subjective_adjective, family="binomial", data=data.click))





data.free$section = "free"
data.click$section = "constrained"

dataProduction = rbind(data.free, data.click)

dataProduction$subjective.vs.color = dataProduction$ADJ1OrColorFirst.Transformed
dataProduction$objective.vs.color = dataProduction$ADJ2OrColorFirst.Transformed

dataProduction$item = (1:nrow(dataProduction))
agr = dataProduction %>%
  group_by(section) %>%
  summarise(Mean = mean(subjective.vs.color, na.rm=TRUE))
agr$alien = "subjective"

agr2 = dataProduction %>%
  group_by(section) %>%
  summarise(Mean = mean(objective.vs.color, na.rm=TRUE))
agr2$alien = "objective"

agr = rbind(agr, agr2)

dodge = position_dodge(.9)

pdf('plots/production.pdf')
ggplot(agr, aes(x=alien, y=Mean)) +
  geom_bar(stat="identity",position=dodge) +
#  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~section) +
  ylab('Alien Adjective before Color') +
  xlab('Type of Alien Adjective')
dev.off()


## JD's code

# Did people actually get the subjectivity manipulation?
d_subj = data %>%
  filter(!is.na(adj1_subj)) %>%
  select(workerid,adj2_subj,adj1_subj,subjective_adjective,objective_adjective) %>%
  gather(AdjType, Adjective, -workerid, -adj2_subj, -adj1_subj) %>%
  gather(SubjValueAdjType, Subjectivity, -workerid,-AdjType,-Adjective) %>%
  filter(AdjType == "subjective_adjective" & SubjValueAdjType == "adj1_subj" | AdjType == "objective_adjective" & SubjValueAdjType == "adj2_subj")
nrow(d_subj)
d_subj

agr = d_subj %>%
  group_by(AdjType) %>%
  summarize(MeanSubjectivity = mean(Subjectivity)) #, CILow=ci.low(Subjectivity), CIHigh=ci.high(Subjectivity)) %>%
#  mutate(YMin=MeanSubjectivity-CILow,YMax=MeanSubjectivity+CIHigh)
dodge = position_dodge(.9)

plot = ggplot(agr, aes(x=AdjType, y=MeanSubjectivity)) +
  geom_bar(stat="identity",position=dodge) +
#  geom_errorbar(aes(ymin=YMin,ymax=YMax),position=dodge,width=.25) +
  geom_line(data=d_subj,aes(group=workerid,y=Subjectivity), alpha=.3) + xlab("Adjective Type") + ylab("Subjectivity Rating") +
  theme(panel.background = element_blank(), axis.text=element_text(size=18, colour="black"), axis.title=element_text(size=18, colour="black"))
pdf('plots/subjectivity-by-subject.pdf')
print(plot)
dev.off()

##################################

# same for faultless disagreement
d_disagreement = data %>%
  filter(!is.na(adj1_disagreement)) %>%
  select(workerid,adj2_disagreement,adj1_disagreement,subjective_adjective,objective_adjective) %>%
  gather(AdjType, Adjective, -workerid, -adj2_disagreement, -adj1_disagreement) %>%
  gather(SubjValueAdjType, FaultlessDisagreement, -workerid,-AdjType,-Adjective) %>%
  filter(AdjType == "subjective_adjective" & SubjValueAdjType == "adj1_disagreement" | AdjType == "objective_adjective" & SubjValueAdjType == "adj2_disagreement")
nrow(d_disagreement)
d_disagreement

agr = d_disagreement %>%
  group_by(AdjType) %>%
  summarize(MeanFaultlessDisagreement = mean(FaultlessDisagreement)) #%>%
#  mutate(YMin=MeanFaultlessDisagreement-CILow,YMax=MeanFaultlessDisagreement+CIHigh)
dodge = position_dodge(.9)

plot = ggplot(agr, aes(x=AdjType, y=MeanFaultlessDisagreement)) +
  geom_bar(stat="identity",position=dodge) +
#  geom_errorbar(aes(ymin=YMin,ymax=YMax),position=dodge,width=.25) +
  geom_line(data=d_disagreement,aes(group=workerid,y=FaultlessDisagreement), alpha=.3) + xlab("Adjective Type") + ylab("Faultless Disagreement Rating") +
  theme(panel.background = element_blank(), axis.text=element_text(size=18, colour="black"), axis.title=element_text(size=18, colour="black"))

pdf('plots/faultless-disagreement-by-subject.pdf')
print(plot)
dev.off()





