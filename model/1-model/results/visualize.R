data = read.csv("16-base/searchResults_0.tsv", sep="\t")

data$EntropyGain = as.numeric(as.character(data$EntropyGain))

data = data[!is.na(data$EntropyGain),]

library(tidyverse)



ggplot(data, aes(kappa2 - kappa1, EntropyGain)) + 
   geom_smooth()

ggplot(data, aes(C1, EntropyGain)) + 
   geom_smooth()

ggplot(data, aes(loss_2, EntropyGain)) + 
   geom_smooth()



precision = 10
data$x = floor(data$kappa1*precision)/precision
data$y = floor(data$kappa2*precision)/precision
agg = aggregate(data["EntropyGain"], by=c(data["x"], data["y"]), mean)

ggplot(agg, aes(y, x, z=EntropyGain, fill=EntropyGain)) + geom_raster(interpolate=TRUE)



precision = 5
data$x = floor(data$C1*precision)/precision
data$y = floor(data$kappa2*precision)/precision
agg = aggregate(data["EntropyGain"], by=c(data["x"], data["y"]), mean)

ggplot(agg, aes(y, x, z=EntropyGain, fill=EntropyGain)) + geom_raster(interpolate=TRUE)




