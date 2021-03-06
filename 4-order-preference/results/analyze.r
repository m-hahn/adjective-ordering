centerColumn = function(data,columnName) {
 newName = (paste(columnName,"Centered",sep="."))
 data[,newName] <- data[,columnName] - mean(data[,columnName], na.rm = TRUE)
 data[,newName] <- data[,newName] / sd(data[,columnName], na.rm = TRUE)
 return(data)
}

data1 = read.csv("csv/order-preference-trials.tsv", sep="\t")
data2 = read.csv("csv/order-preference-2-trials.tsv", sep="\t")
data4 = read.csv("csv/order-preference-3-trials.tsv", sep="\t")
data5 = read.csv("csv/order-preference-4-trials.tsv", sep="\t")
data6 = read.csv("csv/order-preference-5-trials.tsv", sep="\t")
data1$workerid = data1$workerid + 10
data2$workerid = data2$workerid + 20
data4$workerid = data4$workerid + 40
data5$workerid = data5$workerid + 50
data6$workerid = data6$workerid + 60

#data = data3
data=rbind(data1, data2, data4, data5, data6)

# remove people that participated multiple times
data = data[data$workerid != 40,]
data = data[data$workerid != 50,]
data = data[data$workerid != 60,]


color = c("red","green","blue")
texture = c("checkered","striped","spotted", "solid")
material = c("glass", "wooden", "plastic", "metal")

predicate1IsColor = (data$predicate1 %in% color)
predicate1IsTexture = (data$predicate1 %in% texture)
predicate1IsMaterial = (data$predicate1 %in% material)

predicate2IsColor = (data$predicate2 %in% color)
predicate2IsTexture = (data$predicate2 %in% texture)
predicate2IsMaterial = (data$predicate2 %in% material)

assert = function(boolean) {
 if(! boolean) {
    crash()
 }
}

assert(min(predicate1IsColor + predicate1IsTexture + predicate1IsMaterial) == 1)
assert(min(predicate2IsColor + predicate2IsTexture + predicate2IsMaterial) == 1)

data$predicate1.Type = 1 * predicate1IsColor + 2*predicate1IsTexture + 3* predicate1IsMaterial
data$predicate2.Type = 1 * predicate2IsColor + 2*predicate2IsTexture + 3* predicate2IsMaterial

data$predicate1.Type = as.factor(data$predicate1.Type)
data$predicate2.Type = as.factor(data$predicate2.Type)

assert(max(data$predicate1.Type == data$predicate2.Type) == 0)

library(plyr)

data$predicate1.Type = revalue(data$predicate1.Type, c("1"="Color", "2"="Texture", "3"="Material"))
data$predicate2.Type = revalue(data$predicate2.Type, c("1"="Color", "2"="Texture", "3"="Material"))

# response is the value for the predicate1-predicate2 order
data$scoreForColorFirst = (data$response * predicate1IsColor) + ((1-data$response) * predicate2IsColor)

condition.Is.First.Informative = (data$condition == "first_informative") # i.e., color is informative
condition.Is.Second.Informative = (data$condition == "second_informative") # i.e., non-color is informative
condition.Is.Filler = (data$condition == "filler") # i.e., non-color is informative
data$condition.Renumbered = (-1 * condition.Is.First.Informative) + (0*condition.Is.Filler) + (1*condition.Is.Second.Informative)


createUniqueItemIDs = function(data, columnName) {
   newName = (paste(columnName,"Renumbered",sep="."))
   data[,newName] = as.integer(factor(data[,columnName]))
   return (data)
}

aggregate(data["scoreForColorFirst"], by=c(data["condition"], data["noun"]), mean)

data = createUniqueItemIDs(data, 'noun')
data = centerColumn(data, 'condition.Renumbered')
data = centerColumn(data, 'noun.Renumbered')

summary(lmer(scoreForColorFirst ~ condition.Renumbered.Centered + noun.Renumbered.Centered + (condition.Renumbered.Centered|item) + (condition.Renumbered.Centered|workerid) + (1|workerid) + (1|item), data=data))






library(tidyverse)
source("helpers.R")


agr = data %>%
  group_by(condition, predicate1.Type, noun) %>%
  summarise(Mean = mean(response), CILow = ci.low(response), CIHigh = ci.high(response))
dodge = position_dodge(.9)

pdf('plots/response-per-condition.pdf')
ggplot(agr, aes(x=condition,y=Mean,fill=predicate1.Type)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~noun)
dev.off()

agr = data %>%
  group_by(condition, noun) %>%
  summarise(Mean = mean(scoreForColorFirst), CILow = ci.low(scoreForColorFirst), CIHigh = ci.high(scoreForColorFirst))
dodge = position_dodge(.9)

pdf('plots/for-color-first-per-condition.pdf')
ggplot(agr, aes(x=condition,y=Mean)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~noun)
dev.off()


ggplot(data, aes(x=response)) +
  geom_histogram() +
  facet_wrap(~workerid)


agr = data %>%
  group_by(condition, noun, workerid) %>%
  summarise(Mean = mean(scoreForColorFirst), CILow = ci.low(scoreForColorFirst), CIHigh = ci.high(scoreForColorFirst))
dodge = position_dodge(.9)

pdf('plots/by-participant.pdf')
ggplot(agr, aes(x=condition,y=Mean,fill=noun)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~workerid)
dev.off()


data$Quarter = ifelse(data$slide_number < 9, "first","rest")

agr = data %>%
  group_by(condition, noun, Quarter) %>%
  summarise(Mean = mean(scoreForColorFirst), CILow = ci.low(scoreForColorFirst), CIHigh = ci.high(scoreForColorFirst))
dodge = position_dodge(.9)

pdf('plots/by-quarter.pdf')
ggplot(agr, aes(x=condition,y=Mean,fill=Quarter)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~noun)
dev.off()

