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
dataAgg = aggregate(c(data["response_0"],data["response_1"], data["response_2"], data["response_3"], data["response_4"], data["response_5"]), by=(data["adjective"]), mean)

dataAgg = merge(dataAgg, dataSubj, by=c("adjective"))


write.csv(dataAgg, file="24_aggregate_data.csv")





#########################

data = merge(data, dataSubj, by=c("adjective"))


byClass = aggregate(c(data["response_0"], data["response_1"], data["response_2"], data["response_3"], data["response_4"], data["response_5"], data["subjectivity"]), by=c(data["class"]), mean)
byClass = byClass[order(byClass$subjectivity),]
#byClass$classId = (1:nrow(byClass))

#data = merge(data, byClass[, c("class", "classId")], by=c("class"))

source('helpers.R')
library(ggplot2)
library(tidyverse)

library(reshape)

dataM = melt(data, id=c("adjective", "free_input", "item", "response", "class", "workerid", "slide_number"))

agr = dataM %>%
  group_by(class, variable) %>%
  summarise(Mean = mean(value), CILow = ci.low(value), CIHigh = ci.high(value))
dodge = position_dodge(.9)

agr = agr[order(agr$classId),]

# make sure classes are ordered by increasing subjectivity
agr$class = factor(agr$class, levels=byClass$class)

plot = ggplot(agr, aes(x=class,y=Mean)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~variable, scales = "free") + scale_x_discrete( labels = function( labels ) { # user aaiezza on https://stackoverflow.com/questions/19567986/overlapping-axis-labels-in-r
                           fixedLabels <- c() 
                           for ( l in 1:length( labels ) ) { 
                                     fixedLabels <- c( fixedLabels, paste0( ifelse( l %% 2 == 0, '', '\n' ), labels[l] ) ) 
                           }
                            return( fixedLabels ) } ) 
ggsave('plots/by_class.pdf', plot=plot)


library(ggfortify)
p12_0 = autoplot(prcomp(data[,7:12]), data=data, colour = "response_0", x=1, y=2)
p12_1 = autoplot(prcomp(data[,7:12]), data=data, colour = "response_1", x=1, y=2)
p12_2 = autoplot(prcomp(data[,7:12]), data=data, colour = "response_2", x=1, y=2)
p12_3 = autoplot(prcomp(data[,7:12]), data=data, colour = "response_3", x=1, y=2)
p12_4 = autoplot(prcomp(data[,7:12]), data=data, colour = "response_4", x=1, y=2)
p12_5 = autoplot(prcomp(data[,7:12]), data=data, colour = "response_5", x=1, y=2)
p12_s = autoplot(prcomp(data[,7:12]), data=data, colour = "subjectivity", x=1, y=2)

p34_0 = autoplot(prcomp(data[,7:12]), data=data, colour = "response_0", x=3, y=4)
p34_1 = autoplot(prcomp(data[,7:12]), data=data, colour = "response_1", x=3, y=4)
p34_2 = autoplot(prcomp(data[,7:12]), data=data, colour = "response_2", x=3, y=4)
p34_3 = autoplot(prcomp(data[,7:12]), data=data, colour = "response_3", x=3, y=4)
p34_4 = autoplot(prcomp(data[,7:12]), data=data, colour = "response_4", x=3, y=4)
p34_5 = autoplot(prcomp(data[,7:12]), data=data, colour = "response_5", x=3, y=4)
p34_s = autoplot(prcomp(data[,7:12]), data=data, colour = "subjectivity", x=3, y=4)
pdf('plots/pca.pdf')
multiplot(p12_0, p12_1, p12_2, p12_3, p12_4, p12_5, p12_s, p34_0, p34_1, p34_2, p34_3, p34_4, p34_5, p34_s, cols=2)
dev.off()

data = cbind(data, prcomp(data[,7:12])$x)

byClass = aggregate(c(data["response_0"], data["response_1"], data["response_2"], data["response_3"], data["response_4"], data["response_5"], data["subjectivity"], data["PC1"], data["PC2"], data["PC3"], data["PC4"],data["PC5"],data["PC6"]), by=c(data["class"]), mean)



paste(byClass[order(byClass$PC1),]$class, collapse=" ")
paste(byClass[order(byClass$PC2),]$class, collapse=" ")
paste(byClass[order(byClass$PC3),]$class, collapse=" ")
paste(byClass[order(byClass$PC4),]$class, collapse=" ")
paste(byClass[order(byClass$PC5),]$class, collapse=" ")
paste(byClass[order(byClass$PC6),]$class, collapse=" ")

#> prcomp(data[,7:12])
#Standard deviations:
#[1] 0.4919875 0.4087268 0.2870593 0.2316250 0.2271294 0.1148677
#
#Rotation:
#                    PC1        PC2         PC3         PC4         PC5
#response_0 -0.005286641 0.53566320 -0.02776666 -0.77175468  0.33895842
#response_1 -0.039678593 0.61950634 -0.65881818  0.34281632 -0.24919383
#response_2  0.685810041 0.11370385  0.09557383  0.08993807 -0.04389012
#response_3  0.694556130 0.09737958  0.08939763  0.03528180  0.03212026
#response_4 -0.171541705 0.42694045  0.47666703  0.51803767  0.54103588
#response_5 -0.127387104 0.35296931  0.56643612 -0.09578616 -0.72617611
#                     PC6
#response_0  0.0420464456
#response_1 -0.0312332738
#response_2  0.7053980898
#response_3 -0.7055781654
#response_4  0.0009897615
#response_5 -0.0427619783

#> paste(byClass[order(byClass$PC1),]$class, collapse=" ")
#[1] "shape color nationality location material X physical temporal dimension age size speed human texture value quality"
#> paste(byClass[order(byClass$PC2),]$class, collapse=" ")
#[1] "physical X shape texture size location value dimension nationality age speed human quality color temporal material"
#> paste(byClass[order(byClass$PC3),]$class, collapse=" ")
#[1] "texture quality color material nationality value dimension X shape speed physical human temporal size age location"
#> paste(byClass[order(byClass$PC4),]$class, collapse=" ")
#[1] "physical texture human location speed size age shape material quality color X dimension nationality temporal value"
#> paste(byClass[order(byClass$PC5),]$class, collapse=" ")
#[1] "X size shape nationality color texture dimension age material speed location temporal human quality value physical"
#> paste(byClass[order(byClass$PC6),]$class, collapse=" ")
#[1] "age X color location material temporal shape speed nationality value quality human dimension size physical texture"
#> paste(byClass[order(byClass$subjectivity),]$class, collapse=" ")
#[1] "material shape color nationality location temporal physical age dimension X texture speed size human value quality"


dataM = melt(data, id=c("adjective", "free_input", "item", "response", "class", "workerid", "slide_number"))

agr = dataM %>%
  group_by(class, variable) %>%
  summarise(Mean = mean(value), CILow = ci.low(value), CIHigh = ci.high(value))
dodge = position_dodge(.9)



# make sure classes are ordered by increasing subjectivity
byClass = byClass[order(byClass$subjectivity),]
agr$class = factor(agr$class, levels=byClass$class)

plot = ggplot(agr, aes(x=class,y=Mean)) +
  geom_bar(stat="identity",position=dodge) +
  geom_errorbar(aes(ymin=Mean-CILow,ymax=Mean+CIHigh),position=dodge,width=.25) +
  facet_wrap(~variable, scales = "free") + scale_x_discrete( labels = function( labels ) { # user aaiezza on https://stackoverflow.com/questions/19567986/overlapping-axis-labels-in-r
                           fixedLabels <- c() 
                           for ( l in 1:length( labels ) ) { 
                                     fixedLabels <- c( fixedLabels, paste0( ifelse( l %% 2 == 0, '', '\n' ), labels[l] ) ) 
                           }
                            return( fixedLabels ) } ) 
ggsave('plots/by_class_with_pca.pdf', plot=plot, unit="cm", width=50, height=30)



# look at determiner, number
itemData = read.csv("item_data.tsv", sep="\t", header=TRUE)
data = merge(data, itemData, by=c("item"))
dataD = data[data$determiner %in% c("a","the"),]
#summary(lmer(response_5 ~ determiner + (1|workerid) + (1|item), data=dataD))



adjectivesByClass =  select(dataAgg, class=class, adjective=adjective)
adjectivesByClass = adjectivesByClass[order(adjectivesByClass$class),]

#         class     adjective
#20         age         fresh
#31         age        junior
#39         age           new
#40         age           old
#47         age        rotten
#49         age        senior
#65         age         young
#5        color         black
#6        color         brown
#24       color         green
#45       color        purple
#46       color           red
#62       color         white
#64       color        yellow
#22    material          gold
#42    material       plastic
#63    material        wooden
#1      quality           bad
#23     quality          good
#7        shape      circular
#56       shape        square
#3         size           big
#27        size          huge
#34        size          long
#50        size         short
#52        size         small
#60        size          tiny
#53     texture          soft
#4    dimension       biggest
#33   dimension          long
#35   dimension          mini
#37   dimension        narrow
#41   dimension          open
#59   dimension          thin
#8        human     civilized
#9        human      creative
#48       human           sad
#57       human        strict
#28    location      internal
#14 nationality       English
#15 nationality      European
#25 nationality      Hispanic
#29 nationality international
#30 nationality      Japanese
#38 nationality      national
#61 nationality    Vietnamese
#21    physical        frozen
#54    physical         solid
#58    physical         sweet
#18       speed          fast
#51       speed          slow
#55       speed        speedy
#10    temporal       current
#11    temporal         daily
#16    temporal      everyday
#26    temporal    historical
#2        value          best
#17       value      exciting
#19       value      favorite
#43       value      pleasant
#12           X    designated
#13           X     different
#32           X          last
#36           X         mixed
#44           X     potential





#> dataAgg[dataAgg$class == "X",]
#    adjective response_0 response_1 response_2 response_3 response_4 response_5
#12 designated      0.340  0.2033333  0.1433333  0.1300000  0.6166667  0.8400000
#13  different      0.650  0.3935714  0.2607143  0.2571429  0.7257143  0.6935714
#32       last      0.355  0.8250000  0.0800000  0.0450000  0.8800000  0.8400000
#36      mixed      0.645  0.2750000  0.0600000  0.3100000  0.4125000  0.6400000
#44  potential      0.590  0.6350000  0.3775000  0.3675000  0.5687500  0.7775000
#   class subjectivity
#12     X    0.3062500
#13     X    0.6642857
#32     X    0.2866667
#36     X    0.4992647
#44     X    0.6721622


# correlation matrix with significance

#      questions.push('Does it describe the '+stim.noun+'?');
#      questions.push('Does it uniquely identify the '+stim.noun+'?');
#      questions.push('Does it describe how the speaker feels about the '+stim.noun+'?');
#      questions.push('Does it describe the speaker\'s attitude towards the '+stim.noun+'?');
#      questions.push('Does it serve to distinguish the '+stim.noun+' from those that are not '+stim.adjective+'?');
#      questions.push('Do you think other people would mostly agree that the '+stim.noun+(stim.noun.slice(-1) == 's' ? ' are ' : ' is ')+stim.adjective+'?');


printCorrelations = function() {
    cat("By-trial measures\n")
    level0 = 0.05 / 15
    level1 = 0.01 / 15
    level2 = 0.005 / 15

    # Correlations
    for(a in (0:5)) {
     cat("\t",a)
    }
     cat("\n")
    for(a in (1:5)) {
     cat(a, "\t")
     for(b in (0:(a-1))) {
       p = (cor.test(data[[paste("response_",a,sep="")]], data[[paste("response_",b,sep="")]])$p.value)
       star = ""
       if(p < level2) {
         star = "***"
       } else if(p < level1) {
         star = "**"
       } else if(p < level0) {
         star = "*"
       }

       cat(round(cor(data[paste("response_",a,sep="")], data[paste("response_",b,sep="")]),2), star, "\t", sep="")
     }
     cat("\n")
    }
    
   
    ###################################
    cat("Aggregate measures\n")
    
    # Correlations
    for(a in (0:5)) {
     cat("\t",a)
    }
     cat("\n")
    for(a in (1:5)) {
     cat(a, "\t")
     for(b in (0:(a-1))) {
       p = (cor.test(dataAgg[[paste("response_",a,sep="")]], dataAgg[[paste("response_",b,sep="")]])$p.value)
       star = ""
       if(p < level2) {
         star = "***"
       } else if(p < level1) {
         star = "**"
       } else if(p < level0) {
         star = "*"
       }
       cat(round(cor(dataAgg[paste("response_",a,sep="")], dataAgg[paste("response_",b,sep="")]),2), star, "\t", sep="")
     }
     cat("\n")
    }
    
    cat("*","<",level0,",","**","<",level1,",","***","<",level2,"\n", sep=" ")
   
}

#> printCorrelations()
#By-trial measures
#	 0	 1	 2	 3	 4	 5
#1 	0.39***	
#2 	0.05	0	
#3 	0.06	-0.03	0.89***	
#4 	0.3***	0.24***	-0.14	-0.15	
#5 	0.27***	0.16*	-0.09	-0.13	0.36***	
#Aggregate measures
#	 0	 1	 2	 3	 4	 5
#1 	0.45***	
#2 	0.07	-0.25	
#3 	0.1	-0.27	0.97***	
#4 	0.25	0.55***	-0.35	-0.37*	
#5 	0.29	0.27	-0.23	-0.22	0.36*	
#* < 0.003333333 , ** < 0.0006666667 , *** < 0.0003333333 

#summary(lmer(response_4 ~ response_0 + response_1 + response_2 + response_5 + (1|workerid) + (1|adjective), data=data))


#> summary(lm(subjectivity ~ response_0 + response_1 + response_2 + response_4 + response_5, data=dataAgg))
#
#Call:
#lm(formula = subjectivity ~ response_0 + response_1 + response_2 + 
#    response_4 + response_5, data = dataAgg)
#
#Residuals:
#     Min       1Q   Median       3Q      Max 
#-0.29088 -0.08999 -0.00889  0.09522  0.27592 
#
#Coefficients:
#            Estimate Std. Error t value Pr(>|t|)    
#(Intercept)  0.30228    0.10749   2.812   0.0067 ** 
#response_0   0.07314    0.11712   0.624   0.5348    
#response_1  -0.03088    0.11648  -0.265   0.7919    
#response_2   0.56921    0.07529   7.560 3.35e-10 ***
#response_4  -0.10895    0.12607  -0.864   0.3910    
#response_5  -0.02527    0.11230  -0.225   0.8227    
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Residual standard error: 0.1443 on 58 degrees of freedom
#Multiple R-squared:  0.5865,	Adjusted R-squared:  0.5509 
#F-statistic: 16.45 on 5 and 58 DF,  p-value: 4.394e-10


#dataOrder = read.csv("12-order-preference.csv")
#dataOrder = aggregate(dataOrder["response"], by=c(dataOrder["predicate1"]), mean)
#
#dataAgg$predicate1 = dataAgg$adjective
#dataOrder = merge(dataOrder, dataAgg, by=c("predicate1"))
#dataAgg$predicate1 =NULL 
#dataAgg$predicate2 = dataAgg$adjective
#dataOrder = merge(dataOrder, dataAgg, by=c("predicate2"))




