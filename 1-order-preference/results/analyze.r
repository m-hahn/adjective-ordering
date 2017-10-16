centerColumn = function(data,columnName) {
 newName = (paste(columnName,"Centered",sep="."))
 data[,newName] <- data[,columnName] - mean(data[,columnName], na.rm = TRUE)
 data[,newName] <- data[,newName] / sd(data[,columnName], na.rm = TRUE)
 return(data)
}

data1 = read.csv("pilot/run1-order-preference-trials.tsv", sep="\t")
data2 = read.csv("pilot/run2-order-preference-trials.tsv", sep="\t")
data4 = read.csv("pilot/run4-order-preference-trials.tsv", sep="\t")
data5 = read.csv("pilot/run5-order-preference-2-trials.tsv", sep="\t")
data6 = read.csv("pilot/run6-order-preference-3-trials.tsv", sep="\t")
data1$workerid = data1$workerid + 10
data2$workerid = data2$workerid + 20
data4$workerid = data4$workerid + 40
data5$workerid = data5$workerid + 50
data6$workerid = data6$workerid + 60

#data = data3
data=rbind(data1, data2, data4, data5, data6)

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



#aggregate(data["scoreForColorFirst"], by=c(data["condition"], data["noun"]), mean)
#summary(lmer(scoreForColorFirst ~ condition.Renumbered + noun+ (1|workerid) + (1|item), data=data))
#> source('helpers.R')
#> aggregate(data["scoreForColorFirst"], by=c(data["predicate1"]), FUN = function(x) c(mn = mean(x), low = mean(x)-ci.low(x), up = mean(x)+ci.high(x)))


################################
# Differences between adjectives of texture
data$containsCheckeredOrStriped = (data$predicate1 %in% c('checkered', 'striped') | data$predicate2 %in% c('checkered', 'striped'))

data.Ball = data[data$noun == 'ball',]
summary(lmer(scoreForColorFirst ~ condition.Renumbered * containsCheckeredOrStriped+ (1|workerid) + (1|item), data=data.Ball))


dataColorFirst = data[data$predicate1.Type == "Color",]
dataColorSecond = data[data$predicate2.Type == "Color",]

dataColorFirst$NonColorAdjective = dataColorFirst$predicate2
dataColorSecond$NonColorAdjective = dataColorSecond$predicate1

data2 = rbind(dataColorFirst, dataColorSecond)

aggregate(data2["scoreForColorFirst"], by=c(data2["NonColorAdjective"]), FUN = function(x) c(mn = mean(x), sd = sd(x), low = mean(x)-ci.low(x), up = mean(x)+ci.high(x)))   

