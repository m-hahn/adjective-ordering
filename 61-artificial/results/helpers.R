
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


####################################################################################
# Bootstrapping by groups ('pigeonhole bootstrapping')

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

####################################################################################

ci.low.grouped.3D <- function(x,g1,g2,g3,na.rm=T) {
  mean(x,na.rm=na.rm) - quantile(groupedBootstrap3D(x,g1,g2,g3),.025,na.rm=na.rm)}
ci.high.grouped.3D <- function(x,g1,g2,g3,na.rm=T) {
  quantile(groupedBootstrap3D(x,g1,g2,g3),.975,na.rm=na.rm) - mean(x,na.rm=na.rm)}



groupedBootstrap3D = function(data, group1, group2, group3, samples=100) {
  data = data.frame(value=data, group1=group1, group2=group2, group3=group3)

  # Josh O'Brien at https://stackoverflow.com/questions/10036822/how-to-get-a-data-frame-into-a-multidimensional-array-in-r
  library(reshape2)
  
  data$row <- with(data, ave(group1==group1, group1, FUN = cumsum))
  
  m <- melt(data, id.vars = c("row", "group1", "group2", "group3"))
  a <- acast(m, row ~ variable ~ group1 ~ group2 ~ group3)
  return(groupedBootstrap3DMatrix(a, samples=samples))
}

groupedBootstrap3DMatrix = function(dataMatrix, samples=100) {
  means = c()
  for(step in (1:samples)) {
     newC1 = sample((1:dim(dataMatrix)[3]), dim(dataMatrix)[3], replace=TRUE)
     newC2 = sample((1:dim(dataMatrix)[4]), dim(dataMatrix)[4], replace=TRUE)
     newC3 = sample((1:dim(dataMatrix)[5]), dim(dataMatrix)[5], replace=TRUE)

     resampledData = dataMatrix[,,newC1,newC2,newC3]
     newMean = mean(resampledData, na.rm=TRUE)
     means = c(means, newMean)
  }
  return(means)
}

####################################################################################


ci.low.grouped.1D <- function(x,g1,na.rm=T) {
  mean(x,na.rm=na.rm) - quantile(groupedBootstrap1D(x,g1),.025,na.rm=na.rm)}
ci.high.grouped.1D <- function(x,g1,na.rm=T) {
  quantile(groupedBootstrap1D(x,g1),.975,na.rm=na.rm) - mean(x,na.rm=na.rm)}



groupedBootstrap1D = function(data, group1, samples=100) {
  data = data.frame(value=data, group1=group1)

  # Josh O'Brien at https://stackoverflow.com/questions/10036822/how-to-get-a-data-frame-into-a-multidimensional-array-in-r
  library(reshape2)
  
  data$row <- with(data, ave(group1==group1, group1, FUN = cumsum))
  
  m <- melt(data, id.vars = c("row", "group1"))
  a <- acast(m, row ~ variable ~ group1)
  return(groupedBootstrap1DMatrix(a, samples=samples))
}

groupedBootstrap1DMatrix = function(dataMatrix, samples=100) {
  means = c()
  for(step in (1:samples)) {
     newC1 = sample((1:dim(dataMatrix)[3]), dim(dataMatrix)[3], replace=TRUE)

     resampledData = dataMatrix[,,newC1]
     newMean = mean(resampledData, na.rm=TRUE)
     means = c(means, newMean)
  }
  return(means)
}




