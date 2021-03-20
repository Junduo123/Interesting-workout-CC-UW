# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())
#Set work directory
setwd("~/Desktop/Uwaterloo/719/A06")


data <- read.csv("Assignment6_Data.csv")

data_copy <- data.frame(matrix(data = NA, nrow = 1000,ncol = 24))
for (i in seq(colnames(data[grepl("hour.",names(data))]))) {
  for (j in c(1:1000)) {
    if (i == 1){data_copy[j,i] <- data[colnames(data[grepl("hour.",names(data))])][[i]][j]}
    else{data_copy[j,i] <- data[colnames(data[grepl("hour.",names(data))])][[i]][j] +
      data_copy[colnames(data_copy[grepl("hour.",names(data_copy))])][[i-1]][j]}
  }
  colnames(data_copy)[i] <- colnames(data[grepl("hour.",names(data))])[i]
}
data_copy$`Total.sales` <- data$Total.sales

l <- list()
for (j in c(1:1000)) {
  for (i in seq(colnames(data[grepl("hour.",names(data))]))){
    if(data_copy[j,i] >= 1){l[[j]] <- colnames(data_copy[,data_copy[j,] >= 1])}
    else(l[[j]] <- "NA")
  }
  data_copy$`Stock Out At`[j] <- l[[j]][1]
  stock_out <- data_copy[data_copy$`Stock Out At` != 'NA' & data_copy$`Stock Out At` != "hour.24",]
  not_stock_out <- data_copy[data_copy$`Stock Out At` == 'NA' | data_copy$`Stock Out At` == "hour.24",]
  stock_out$`num(Stock Out At)` <- sub("hour.","",stock_out$`Stock Out At`)
}

# k-means
set.seed(123)
wcss = vector()
for (i in 1:5) wcss[i] = sum(kmeans(stock_out[,1:24], i)$withinss)
plot(1:5,
     wcss,
     type = 'b',
     main = paste('The Elbow Method'),
     xlab = 'Number of clusters',
     ylab = 'WCSS')

kmodel <- kmeans(stock_out[,1:24],3,nstart = 20)
centers <- kmodel$centers
stock_out$cluster <- kmodel$cluster

for (i in seq(nrow(stock_out))) {
  stock_out$`Actual Demand`[i] <- 
    stock_out$Total.sales[i]/(1-sum(centers[stock_out$cluster[i],stock_out$`num(Stock Out At)`[i]:24])/100)
  }
