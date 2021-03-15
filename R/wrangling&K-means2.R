# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())
#Set work directory
setwd("~/Desktop/Uwaterloo/719/A06")


data <- read.csv("Assignment6_Data.csv")
data$`Total.Percentage` <- apply(data[colnames(data[grepl("hour.",colnames(data))])], MARGIN =1, FUN=sum)
data$`Actual Demand` <- round(data$Total.sales * data$Total.Percentage,0)


data_copy <- data.frame(matrix(data = NA, nrow = 1000,ncol = 24))
for (i in seq(colnames(data[grepl("hour.",names(data))]))) {
  for (j in c(1:1000)) {
    if (i == 1){data_copy[j,i] <- data[colnames(data[grepl("hour.",names(data))])][[i]][j]}
    else{data_copy[j,i] <- data[colnames(data[grepl("hour.",names(data))])][[i]][j] +
      data_copy[colnames(data_copy[grepl("hour.",names(data_copy))])][[i-1]][j]}
  }
  colnames(data_copy)[i] <- colnames(data[grepl("hour.",names(data))])[i]
}

l <- list()
for (j in c(1:1000)) {
  for (i in seq(colnames(data[grepl("hour.",names(data))]))){
    if(data_copy[j,i] >= 1){l[[j]] <- colnames(data_copy[,data_copy[j,] >= 1])}
    else(l[[j]] <- "NA")
  }
  data_copy$`Stock Out At`[j] <- l[[j]][1]
  data_copy2 <- data_copy[data_copy$`Stock Out At` != 'NA',]
  data_copy2$`num(Stock Out At)` <- sub("hour.","",data_copy2$`Stock Out At`)
}

# k-means
set.seed(123)
wcss = vector()
for (i in 1:5) wcss[i] = sum(kmeans(data_copy2$`num(Stock Out At)`, i)$withinss)
plot(1:5,
     wcss,
     type = 'b',
     main = paste('The Elbow Method'),
     xlab = 'Number of clusters',
     ylab = 'WCSS')

#data_copy <- cbind(data[,c(1:3,28:29)],data_copy)
