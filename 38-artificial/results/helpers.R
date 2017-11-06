
myCenter <- function(x) {
  if (is.numeric(x)) { return(x - mean(x)) }
  if (is.factor(x)) {
    x <- as.numeric(x)
    return(x - mean(x))
  }
  if (is.data.frame(x) || is.matrix(x)) {
    m <- matrix(nrow=nrow(x), ncol=ncol(x))
    colnames(m) <- paste("c", colnames(x), sep="")
    for (i in 1:ncol(x)) {
      if (is.factor(x[,i])) {
        y <- as.numeric(x[,i])
        m[,i] <- y - mean(y, na.rm=T)
      }
      if (is.numeric(x[,i])) {
        m[,i] <- x[,i] - mean(x[,i], na.rm=T)
      }
    }
    return(as.data.frame(m))
  }
}

se <- function(x)
{
  y <- x[!is.na(x)] # remove the missing values, if any
  sqrt(var(as.vector(y))/length(y))
}

zscore <- function(x){
  ## Returns z-scored values
  x.mean <- mean(x)
  x.sd <- sd(x)
  
  x.z <- (x-x.mean)/x.sd
  
  return(x.z)
}

zscoreByGroup <- function(x, groups){ 
  #Compute zscores within groups
  out <- rep(NA, length(x))
  
  for(i in unique(groups)){
    out[groups == i] <- zscore(x[groups == i])
  }
  return(out)
}

## for bootstrapping 95% confidence intervals
library(bootstrap)
theta <- function(x,xdata,na.rm=T) {mean(xdata[x],na.rm=na.rm)}
ci.low <- function(x,na.rm=T) {
  mean(x,na.rm=na.rm) - quantile(bootstrap(1:length(x),1000,theta,x,na.rm=na.rm)$thetastar,.025,na.rm=na.rm)}
ci.high <- function(x,na.rm=T) {
  quantile(bootstrap(1:length(x),1000,theta,x,na.rm=na.rm)$thetastar,.975,na.rm=na.rm) - mean(x,na.rm=na.rm)}

ci.low.grouped <- function(x,g1,g2,na.rm=T) {
  mean(x,na.rm=na.rm) - quantile(groupedBootstrap(x,g1,g2),.025,na.rm=na.rm)}
ci.high.grouped <- function(x,g1,g2,na.rm=T) {
  quantile(groupedBootstrap(x,g1,g2),.975,na.rm=na.rm) - mean(x,na.rm=na.rm)}



groupedBootstrap = function(data, group1, group2, samples=100) {
  data = data.frame(value=data, group1=group1, group2=group2)
  library("data.table")
  data = dcast(setDT(data), group2 ~ group1, value.var=c("value"))
  # remove the column "group2"
  data$group2 = NULL
  data = data.matrix(data)
  return(groupedBootstrapMatrix(data, samples=samples))
}

groupedBootstrapMatrix = function(dataMatrix, samples=100) {
  means = c()
  for(step in (1:samples)) {
     newColumns =  sample((1:ncol(dataMatrix)), ncol(dataMatrix), replace=TRUE)
     newRows = sample((1:nrow(dataMatrix)), nrow(dataMatrix), replace=TRUE)
     resampledData = dataMatrix[newRows,newColumns]
     newMean = mean(resampledData, na.rm=TRUE)
     means = c(means, newMean)
  }
  return(means)
}


centerColumn = function(data,columnName) {
 newName = (paste(columnName,"Centered",sep="."))
 data[,newName] <- data[,columnName] - mean(data[,columnName], na.rm = TRUE)
 data[,newName] <- data[,newName] / sd(data[,columnName], na.rm = TRUE)
 return(data)
}

