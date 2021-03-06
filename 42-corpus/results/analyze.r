# use render for rmarkdown


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

for(i in (2:10)) {
  dataNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-trials-postprocessed.tsv",sep=""), sep="\t")
  dataNew$workerid = dataNew$workerid + i*9
  data = rbind(data, dataNew)

  dataSNew = read.csv(paste("../Submiterator-master/order-preference-",i,"-subject_information.tsv", sep=""), sep="\t")
  dataSNew$workerid = dataSNew$workerid + i*9
  dataS = rbind(dataS, dataSNew)
}


getSubjRatings = function() {
 dataSubj1 = read.table("subjectivity-trials.csv",header=TRUE,sep=",")
  dataSubj1$X = 1
  dataSubj1$language = "UNK"

  dataSubj2 = read.table("13-subjectivity-trials.csv",header=TRUE,sep=",")
  dataSubj =rbind(dataSubj1, dataSubj2)
  dataSubj = aggregate(dataSubj["response"],by=c(dataSubj["predicate"], dataSubj["class"]), mean, na.rm=TRUE)

  dataSubj$subjectivity = dataSubj$response
  dataSubj$adjective = dataSubj$predicate
  dataSubj$response = NULL
  dataSubj$predicate = NULL
  return(dataSubj)
}

dataSubj = getSubjRatings()
dataAgg = aggregate(c(data["response_0"],data["response_1"], data["response_2"], data["response_3"]), by=(data["adjective"]), mean)

dataAgg = merge(dataAgg, dataSubj, by=c("adjective"))


write.csv(dataAgg, file="24_aggregate_data.csv")


library(ggplot2)

library(tidyverse)

agr = data %>% 
  select(response_0, response_1, response_2, response_3, response_4, response_5) %>%
  rename("Question 1" = response_0,"Question 2" = response_1,"Question 3" = response_2,"Question 4" = response_3) %>%
  gather(species, val) #%>% 
#  slice(rep(row_number(), val)) %>% 
 # select(-val)

agr$species = as.factor(agr$species)

# violin plots
plot = ggplot(agr, aes(x=species,y=val)) +
  geom_violin(draw_quantiles=c(0.25,0.5,0.75)) + ylab(NULL) + xlab(NULL)
ggsave('plots/responses_violin.pdf', plot=plot)






library(tidyverse)


#########################

data = merge(data, dataSubj, by=c("adjective"))

data$response_3 = as.numeric(as.character(data$response_3))

library(lme4)

#  questions.push('Before the last sentence, have they been talking about '+plural+' in general?');
summary(lmer(response_0 ~ subjectivity + (1|workerid) + (1|item), data=data))
#  questions.push('Before the last sentence, have they been talking about '+demonstrative+' specific '+stim.noun+'?');
summary(lmer(response_1 ~ subjectivity + (1|workerid) + (1|item), data=data))
#  questions.push('Does `'+stim.noun+'\' refer to a previously described situation?');
summary(lmer(response_2 ~ subjectivity + (1|workerid) + (1|item), data=data))
#  questions.push('Before the last sentence, did both speakers know that the '+stim.noun+' '+verb+' '+article+' '+stim.adjective+' '+stim.noun+'?');
summary(lmer(response_3 ~ subjectivity + (1|workerid) + (1|item), data=data))




byClass = aggregate(c(data["response_0"], data["response_1"], data["response_2"], data["response_3"], data["subjectivity"]), by=c(data["class"]), mean)
byClass = byClass[order(byClass$subjectivity),]



detach("package:data.table", unload=TRUE)
source('helpers.R')
#source("rlang")
data$response_4 = data$subjectivity
for(i in (0:4)) {
   name = paste("response_",i,sep="") # sym(...)
   agr = data %>%
     rename_(.dots = list(value = name)) %>%
     group_by(class) %>%
     summarise(Mean = mean(value), CILow = ci.low(value), CIHigh = ci.high(value))
   dodge = position_dodge(.9)
   
   #agr = agr[order(agr$classId),]
   
   # make sure classes are ordered by increasing subjectivity
   agr$class = factor(agr$class, levels=byClass$class)
   
   plot = ggplot(agr, aes(x=class,y=Mean)) +
     geom_bar(stat="identity",position=dodge) +
     geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
   scale_x_discrete( labels = function( labels ) { # user aaiezza on https://stackoverflow.com/questions/19567986/overlapping-axis-labels-in-r
                              fixedLabels <- c() 
                              for ( l in 1:length( labels ) ) { 
                                        fixedLabels <- c( fixedLabels, paste0( ifelse( l %% 2 == 0, '', '\n' ), labels[l] ) ) 
                              }
                               return( fixedLabels ) } ) +xlab(NULL) + ylab(NULL)
   
   ggsave(paste('plots/response_',i,'_by_class.pdf',sep=""), plot=plot, width=7, height=4)
}







