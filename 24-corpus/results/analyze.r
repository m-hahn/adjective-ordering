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
  dataSubj = aggregate(dataSubj["response"],by=dataSubj["predicate"], mean, na.rm=TRUE)

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


# correlation matrix with significance

#summary(lmer(data$response_1 ~ data$subjectivity + (1|adjective) + (1|workerid), data=data))


#      questions.push('Does it describe the '+stim.noun+'?');
#      questions.push('Does it uniquely identify the '+stim.noun+'?');
#      questions.push('Does it describe how the speaker feels about the '+stim.noun+'?');
#      questions.push('Does it describe the speaker\'s attitude towards the '+stim.noun+'?');
#      questions.push('Does it serve to distinguish the '+stim.noun+' from those that are not '+stim.adjective+'?');
#      questions.push('Do you think other people would mostly agree that the '+stim.noun+(stim.noun.slice(-1) == 's' ? ' are ' : ' is ')+stim.adjective+'?');



# TODO predict order ratings

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




