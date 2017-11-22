source('helpers.R')
library(lme4)
library(ggplot2)

# Read trial and subjects data

data = read.csv("../Submiterator-master/order-preference-trials-postprocessed.tsv", sep="\t")
dataS = read.csv("../Submiterator-master/order-preference-subject_information.tsv", sep="\t")

for(i in c(2:5)) {
  dataNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-trials-postprocessed.tsv",sep=""), sep="\t")
  dataNew$workerid = as.numeric(dataNew$workerid) + i*9
  data = rbind(data, dataNew)

  dataSNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-subject_information.tsv", sep=""), sep="\t")
  dataSNew$workerid = as.numeric(dataSNew$workerid) + i*9
  dataS = rbind(dataS, dataSNew)
}


library(tidyverse)

# rename some columns for clarity
dataS = dataS %>% rename(subjective_adjective = adjective1, objective_adjective = adjective2)

# Exclude workers who did not do well on the comprehension task
data$correctQuiz = (data$correct_response == data$quiz_response)
correctByWorker = aggregate(data["correctQuiz"], by=c(data["workerid"]), mean, na.rm=TRUE)
dataS = merge(dataS, correctByWorker)
dataS = dataS[dataS$correctQuiz > 0.85,]

########################################################
# look at whether the manipulation worked

subjAgr = aggregate(c(data["adj1_disagreement"], data["adj2_disagreement"], data["adj1_subj"], data["adj2_subj"]), by=c(data["workerid"]), mean, na.rm=TRUE)

subjAgr$disagrDiff = subjAgr$adj1_disagreement - subjAgr$adj2_disagreement
subjAgr$subjDiff = subjAgr$adj1_subj - subjAgr$adj2_subj
data$adj1_subj = NULL
data$adj2_subj = NULL
data$adj1_disagreement = NULL
data$adj1_disagreement = NULL

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
m = lmer(response ~ subjectiveFirst + (subjectiveFirst|workerid) + (1|workerid) + (1|predicate1) + (1|predicate2), data=dataAA)
summary(m)

dataAA = centerColumn(dataAA, "subjDiff")
dataAA = centerColumn(dataAA, "disagrDiff")
m = lmer(response ~ subjectiveFirst.Centered*subjDiff.Centered +(subjectiveFirst|workerid) + (1|workerid) + (1|predicate1) + (1|predicate2), data=dataAA)
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
agr = dataAA %>%
  group_by(ManipulationEffect, subjectiveFirst.Label) %>%
  summarise(Mean = mean(response), CILow = ci.low.grouped(dataAA$response, dataAA$workerid, (1:nrow(dataAA))), CIHigh = ci.high.grouped(dataAA$response, dataAA$workerid, (1:nrow(dataAA))))
dodge = position_dodge(.9)

pdf('plots/alien-pairs-order-ratings-by-manipulation-effect.pdf')
ggplot(agr, aes(x=subjectiveFirst.Label,y=Mean, fill=ManipulationEffect)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  ylab('Rating') +
  xlab('Ordering of Alien Adjectives')
dev.off()



dataAA$manipulationEffectFaultless = ifelse(dataAA$subjDiff < 0.0, "0 Opposite", ifelse(dataAA$subjDiff < 0.4, "1 Small", "2 Big"))
agr = dataAA %>%
  group_by(manipulationEffectFaultless, subjectiveFirst.Label) %>%
  summarise(Mean = mean(response), CILow = ci.low.grouped(dataAA$response, dataAA$workerid, (1:nrow(dataAA))), CIHigh = ci.high.grouped(dataAA$response, dataAA$workerid, (1:nrow(dataAA))))
dodge = position_dodge(.9)

pdf('plots/alien-pairs-order-ratings-by-manipulation-effect-faultless.pdf')
ggplot(agr, aes(x=subjectiveFirst.Label,y=Mean, fill=manipulationEffectFaultless)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  ylab('Rating') +
  xlab('Ordering of Alien Adjectives')
dev.off()



agr = dataAA %>%
  group_by(subjectiveFirst.Label) %>%
  summarise(Mean = mean(response), CILow = ci.low(dataAA$response), CIHigh = ci.high(dataAA$response))
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

library(tidyverse)

data2$preference1 = 0
data2$preference2 = 0

# TODO for now, removed these, since only some adjectives appeared in 35/36
# read order ratings (aggregated by individual adjectives) from norming study as a control predictor
#orderNorm = read.csv("../../36-artificial/results/alien-order-norm.tsv")
#oNorm1 = orderNorm %>% rename(predicate1 = predicate, preference1 = response)
#oNorm2 = orderNorm %>% rename(predicate2 = predicate, preference2 = response)
#oNorm2$preference2 = 1-oNorm2$preference2
#data2 = merge(data2, oNorm1, by=c("predicate1"))
#data2 = merge(data2, oNorm2, by=c("predicate2"))

# select the alien adjective
data2$nonAlienAdjective = ifelse(data2$a1, as.character(data2$predicate2), as.character(data2$predicate1))
data2$nonAlienAdjectiveIsColor = (data2$nonAlienAdjective %in% c("red", "green", "blue"))

data5 = rbind(data2)
# does the trial occur in the In-Context block, or in the other ratings block?
data5$inContext = !is.na(data5$relevant_adjective)
data5 = centerColumn(data5, "inContext")
data5 = centerColumn(data5, "alienWordIsFirst")
data5 = centerColumn(data5, "nonAlienAdjectiveIsColor")
data5 = centerColumn(data5, "subjDiff")

# MAIN ANALYSIS
# Analysis: predict rating for `alien first' based on containsSubjectiveAdjective
# The prediction is that the effect of containsSubjectiveAdjective on responseAlienFirst is positive
# (i.e., ratings for alien-first increase when the alien adjective is subjective)
# Unlike Experiment 30, this effect is not shown here.
m = lmer(responseAlienFirst ~ nonAlienAdjectiveIsColor.Centered*inContext.Centered*containsSubjectiveAdjective.Centered + preference1 + preference2 + (1|workerid), data=data5)
summary(m)

m = lmer(responseAlienFirst ~ containsSubjectiveAdjective.Centered + preference1 + preference2 + (1|workerid), data=data5)
summary(m)


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
data5$containsSubjectiveAdjective.Label = ifelse(data5$containsSubjectiveAdjective, "scalar", "objective")

agr = data5 %>%
  group_by(containsSubjectiveAdjective.Label, nonAlienAdjectiveIsColor.Label, inContext.Label) %>%
  summarise(Mean = mean(responseAlienFirst), CILow = ci.low.grouped(data5$responseAlienFirst, data5$workerid, (1:nrow(data5))), CIHigh = ci.high.grouped(data5$responseAlienFirst, data5$workerid, (1:nrow(data5))))
dodge = position_dodge(.9)

pdf('plots/order-ratings.pdf')
ggplot(agr, aes(x=containsSubjectiveAdjective.Label,y=Mean,fill=containsSubjectiveAdjective.Label)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~nonAlienAdjectiveIsColor.Label+inContext.Label)+
  ylab('Rating for Alien First') +
  xlab('Type of Alien Adjective')
dev.off()

# plot by effect strength of manipulation
data5$manipulationEffect = ifelse(data5$subjDiff < 0.0, "0 Opposite", ifelse(data5$subjDiff < 0.4, "1 Small", "2 Big"))
agr = data5 %>%
  group_by(manipulationEffect, containsSubjectiveAdjective.Label, nonAlienAdjectiveIsColor.Label, inContext.Label) %>%
  summarise(Mean = mean(responseAlienFirst), CILow = ci.low.grouped(data5$responseAlienFirst, data5$workerid, (1:nrow(data5))), CIHigh = ci.high.grouped(data5$responseAlienFirst, data5$workerid, (1:nrow(data5))))
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
agr = data5 %>%
  group_by(manipulationEffectFaultless, containsSubjectiveAdjective.Label, nonAlienAdjectiveIsColor.Label, inContext.Label) %>%
  summarise(Mean = mean(responseAlienFirst), CILow = ci.low.grouped(data5$responseAlienFirst, data5$workerid, (1:nrow(data5))), CIHigh = ci.high.grouped(data5$responseAlienFirst, data5$workerid, (1:nrow(data5))))
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


agr = dataProduction %>%
  group_by(section) %>%
  summarise(Mean = mean(subjective.vs.color, na.rm=TRUE), CILow = ci.low.grouped(dataProduction$subjective.vs.color, dataProduction$workerid, (1:length(dataProduction$subjective.vs.color))), CIHigh = ci.high.grouped(dataProduction$subjective.vs.color, dataProduction$workerid, (1:length(dataProduction$subjective.vs.color))))
agr$alien = "subjective"

agr2 = dataProduction %>%
  group_by(section) %>%
  summarise(Mean = mean(objective.vs.color, na.rm=TRUE), CILow = ci.low.grouped(dataProduction$objective.vs.color, dataProduction$workerid, (1:length(dataProduction$objective.vs.color))), CIHigh = ci.high.grouped(dataProduction$objective.vs.color, dataProduction$workerid, (1:length(dataProduction$objective.vs.color))))
agr2$alien = "objective"

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
  summarize(MeanSubjectivity = mean(Subjectivity), CILow=ci.low(Subjectivity), CIHigh=ci.high(Subjectivity)) %>%
  mutate(YMin=MeanSubjectivity-CILow,YMax=MeanSubjectivity+CIHigh)
dodge = position_dodge(.9)

pdf('plots/subjectivity-by-subject.pdf')
ggplot(agr, aes(x=AdjType, y=MeanSubjectivity)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=YMin,ymax=YMax),position=dodge,width=.25) +
  geom_line(data=d_subj,aes(group=workerid,y=Subjectivity), alpha=.3) + xlab("Adjective Type") + ylab("Subjectivity Rating") +
  theme(panel.background = element_blank(), axis.text=element_text(size=18, colour="black"), axis.title=element_text(size=18, colour="black"))
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
  summarize(MeanFaultlessDisagreement = mean(FaultlessDisagreement), CILow=ci.low(FaultlessDisagreement), CIHigh=ci.high(FaultlessDisagreement)) %>%
  mutate(YMin=MeanFaultlessDisagreement-CILow,YMax=MeanFaultlessDisagreement+CIHigh)
dodge = position_dodge(.9)

ggplot(agr, aes(x=AdjType, y=MeanFaultlessDisagreement)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=YMin,ymax=YMax),position=dodge,width=.25) +
  geom_line(data=d_disagreement,aes(group=workerid,y=FaultlessDisagreement), alpha=.3)




