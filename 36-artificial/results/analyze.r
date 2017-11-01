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

for(i in (2:22)) {
  dataNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-trials.tsv",sep=""), sep="\t")
  dataNew$workerid = dataNew$workerid + i*9
  data = rbind(data, dataNew)

  dataSNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-subject_information.tsv", sep=""), sep="\t")
  dataSNew$workerid = dataSNew$workerid + i*9
  dataS = rbind(dataS, dataSNew)
}

data = merge(data, dataS, by=c("workerid"))




library(tidyverse)

data1 = data %>% rename(predicate = predicate1, other=predicate2)
data2 = data %>% rename(predicate = predicate2, other=predicate1)
data2$response = (1-data2$response)
dataM = cbind(data1, data2)
byPred = aggregate(dataM["response"], by=c(dataM["predicate"]), mean)

write.csv(byPred, file="alien-order-norm.tsv")

dataA = data[!(data$predicate1 %in% c("green","red","blue","small","big")),]
dataA = dataA[!(dataA$predicate2 %in% c("green","red","blue","small","big")),]

byPair = aggregate(dataA["response"], by=c(dataA["predicate1"], dataA["predicate2"]), mean)
byPair = byPair[order(byPair$response),]

source('helpers.R')

agr = dataA %>%
  group_by(predicate1, predicate2) %>%
  summarise(Mean = mean(response), CILow = ci.low(response), CIHigh = ci.high(response))
dodge = position_dodge(.9)

plot = ggplot(agr, aes(x=predicate2, y=Mean)) + 
   geom_bar(stat="identity",position=dodge) +
   geom_errorbar(aes(ymin=Mean-CILow, ymax=Mean+CIHigh), position=dodge,width=.25) +
   facet_wrap(~predicate1)
ggsave('plots/alien_pairs.pdf', plot=plot) 

library('ggfortify')
plot1 = ggplot(agr, aes(x=predicate1, y=predicate2, fill=Mean)) + geom_tile()
plot2 = ggplot(agr, aes(x=predicate1, y=predicate2, fill=Mean-CILow)) + geom_tile()
plot3 = ggplot(agr, aes(x=predicate1, y=predicate2, fill=Mean+CIHigh)) + geom_tile()

source('helpers.R')
pdf('plots/alien_pairs_matrix.pdf')
multiplot(plot2, plot3, plot1, cols=2)
dev.off()

library('tidyverse')
dataAOpposite = dataA %>% rename(pred1 = predicate2, pred2 = predicate1) %>% rename(predicate1 = pred1, predicate2 = pred2)
dataAOpposite$response = 1-dataAOpposite$response

dataA2 = rbind(dataA, dataAOpposite)

agr = dataA2 %>%
  group_by(predicate1, predicate2) %>%
  summarise(Mean = mean(response), CILow = ci.low(response), CIHigh = ci.high(response))
dodge = position_dodge(.9)


plot = ggplot(agr, aes(x=predicate2, y=Mean)) + 
   geom_bar(stat="identity",position=dodge) +
   geom_errorbar(aes(ymin=Mean-CILow, ymax=Mean+CIHigh), position=dodge,width=.25) +
   facet_wrap(~predicate1)
ggsave('plots/alien_pairs_merged.pdf', plot=plot) 

library('ggfortify')
plot1 = ggplot(agr, aes(x=predicate1, y=predicate2, fill=Mean)) + geom_tile()
plot2 = ggplot(agr, aes(x=predicate1, y=predicate2, fill=Mean-CILow)) + geom_tile()
plot3 = ggplot(agr, aes(x=predicate1, y=predicate2, fill=Mean+CIHigh)) + geom_tile()

source('helpers.R')
pdf('plots/alien_pairs_matrix_merged.pdf')
multiplot(plot2, plot3, plot1, cols=2)
dev.off()




#### with colors
dataOpposite = data %>% rename(pred1 = predicate2, pred2 = predicate1) %>% rename(predicate1 = pred1, predicate2 = pred2)
dataOpposite$response = 1-dataOpposite$response

data2 = rbind(data, dataOpposite)

dataNA = data2[(data2$predicate2 %in% c("green","red","blue","small","big")),]

agr = dataNA %>%
  group_by(predicate1, predicate2) %>%
  summarise(Mean = mean(response), CILow = ci.low(response), CIHigh = ci.high(response))
dodge = position_dodge(.9)


plot = ggplot(agr, aes(x=predicate2, y=Mean)) + 
   geom_bar(stat="identity",position=dodge) +
   geom_errorbar(aes(ymin=Mean-CILow, ymax=Mean+CIHigh), position=dodge,width=.25) +
   facet_wrap(~predicate1)
ggsave('plots/alien_english_merged.pdf', plot=plot) 

library('ggfortify')
plot1 = ggplot(agr, aes(x=predicate1, y=predicate2, fill=Mean)) + geom_tile()
plot2 = ggplot(agr, aes(x=predicate1, y=predicate2, fill=Mean-CILow)) + geom_tile()
plot3 = ggplot(agr, aes(x=predicate1, y=predicate2, fill=Mean+CIHigh)) + geom_tile()

source('helpers.R')
pdf('plots/alien_english_matrix_merged.pdf')
multiplot(plot2, plot3, plot1, cols=2)
dev.off()




#aggregate(dataS["workerid"], by=c(dataS["adjective1"], dataS["adjective2"]), NROW)
