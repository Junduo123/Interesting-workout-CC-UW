# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())
#Set work directory
setwd("~/Desktop/Uwaterloo/719/A05")

# Library packages
if(!require(readxl)){install.packages("readxl")}
library(readxl)

if(!require(arules)){install.packages("arules")}
library(arules)

data <- read_excel("Assignment5_Data.xlsx")

top_20_members <- sort(table(data$Member),decreasing = TRUE)[1:20]
data <- subset(data, data$Member %in% names(top_20_members))

for (i in seq(names(top_20_members))) {
  for (j in seq(names(table(data$Member)))) {
    if(names(top_20_members)[i] == names(table(data$Member))[j]){
      data$freq[data$Member == names(top_20_members)[i]] <- top_20_members[i][[1]]
      data <- data[with(data,order(-freq)),]
    }
  }
}
for (i in seq(top_20_members)) {
  for (j in seq(data$Member)) {
    if (names(top_20_members[i]) == data$Member[j]){
      data$location[j] <- seq(top_20_members)[i]
    }
  }
}

current_basket <- read.csv("current_basket.csv")
m <- matrix(0, nrow = 20, ncol = 6); m[,1] <- seq(1:20)
item_names <- c('location',"Item1",'Item2','Item3','Item4','Item5')
for (i in seq(nrow(m))) {
  for (j in 2:6) {
    if (m[i,1] == names(table(data$location))[i]){ 
      m[i,j] <- tryCatch(table(data$Description[data$Member == names(top_20_members[i])])[[trimws(current_basket[i,j])]],
                         error = function(e) print(NA))
    }
  }
}

colnames(m) <- item_names
m[is.na(m)] <- 0

arule <- apriori(m[,2:6])
inspect(arule[1:20])
