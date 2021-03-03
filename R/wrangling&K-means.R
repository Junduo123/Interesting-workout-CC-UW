# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())
#Set work directory
setwd("~/Desktop/Uwaterloo/719/A06")

# Library packages
if(!require(reshape2)){install.packages("reshape2")}
library(reshape2)

data <- read.csv("Assignment6_Data.csv")

data$`Total.Percentage` <- apply(data[colnames(data[grepl("hour.",colnames(data))])], MARGIN =1, FUN=sum)
nrow(data[data$Total.Percentage < 1,])
par(mfrow=c(2,2))
for (i in c(1,2)) {
  for (j in c(1,2)) {
    plot(data[data$Department == levels(data$Department)[i]&
                data$Event.Part.of.the.day == levels(data$Event.Part.of.the.day)[j],]$Total.Percentage,
         ylab  = "",
         main = paste0("Department: ",levels(data$Department)[i],
                       "Part of the day: ",levels(data$Event.Part.of.the.day)[j]))
  }
}
par(mfrow=c(1,1))

# k-means I
norm01 <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
data$Total.Percentage <- norm01(data$Total.Percentage)

set.seed(123)
wcss = vector()
for (i in 1:10) wcss[i] = sum(kmeans(data$Total.Percentage, i)$withinss)
plot(1:10,
     wcss,
     type = 'b',
     main = paste('The Elbow Method for Sale Proportion'),
     xlab = 'Number of clusters',
     ylab = 'WCSS')

data_copy <- data.frame(matrix(data = NA, nrow = 1000,ncol = 24))
for (i in seq(colnames(data[grepl("hour.",names(data))]))) {
  for (j in c(1:1000)) {
    data_copy[j,i] <- round(data[j,colnames(data[grepl("hour.",names(data))])[i]] * data$Total.sales[i],0)
  }
  colnames(data_copy)[i] <- colnames(data[grepl("hour.",names(data))])[i]
}
data_copy2 <- cbind(data[,c(1:3)],data_copy)
data_copy2 <- melt(data_copy2,id.vars = c("Item.","Department","Event.Part.of.the.day"))

# double check the result form melt() function
l <- list()
for (i in c(1:nrow(data_copy))) {
  l[[i]] <- data_copy[,colnames(data_copy[grepl("hour.",names(data_copy))])[i]]
  for (k in seq(l)) {
    names(l)[k] <- colnames(data[,grepl("hour.",names(data))])[k]
  }
}

# k-means II
data_copy2$value <- norm01(data_copy2$value)

set.seed(123)
wcss = vector()
for (i in 1:10) wcss[i] = sum(kmeans(data_copy2$value, i)$withinss)
plot(1:10,
     wcss,
     type = 'b',
     main = paste('The Elbow Method'),
     xlab = 'Number of clusters',
     ylab = 'WCSS')

