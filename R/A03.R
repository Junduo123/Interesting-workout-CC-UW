# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())
#Set work directory
setwd("~/Desktop/Uwaterloo/719/A03")

# Library packages
if(!require(readxl)){install.packages("readxl")}
library(readxl)

if(!require(smooth)){install.packages("smooth")}
library("smooth")

data <- read_excel("Assignment3_Data.xlsx")

#Q1
values = vector(mode='numeric')
dates = vector()
for (i in seq(table(data[data$`Stock Creation Date`>="2018-07-01"&
                         data$`Stock Creation Date`<="2018-09-30",]
                    $`Stock Creation Date`))){
  dates[i] <- names(table(data[data$`Stock Creation Date`>="2018-07-01"&
                                 data$`Stock Creation Date`<="2018-09-30",]
                          $`Stock Creation Date`))[i]
  values[i] <- table(data$`Stock Creation Date`)[[i]]
  # "2018-09-22" to "2018-09-30": test [82:90]
}

l = list(1,2,3)
sma_names <- c("SMA1","SMA2","SMA3")
for (i in c(1:3)) {
  sma_index <- sma(ts(data.frame(values[1:81])),i)
  l[[i]][1] <- sma_index['lossValue']
  #names(l[[i]][1]) <- 'MSE'
  l[[i]][2] <- forecast(sma_index,3)['forecast']
  #names(l[[i]][2]) <-'predicted value'
  names(l)[i] <- sma_names[i]
}

# Q2
par(mfrow=c(3,1))
acf(values[1:81]);pacf(values[1:81]);plot.ts(values)
forecast(ar(values[1:81],aic = FALSE, order.max = 1),3)

# Q3
l2 = list(1,2,3)
ar_names <- "AR1"
for (i in c(1:3)) {
  sma_index2 <- accuracy(forecast(sma(ts(data.frame(values[1:81])),i),3))
  l2[[i]][1] <- 'MAD'
  l2[[i]][2] <- round(sma_index2[1],2)
  l2[[i]][3] <- 'RMSE'
  l2[[i]][4] <- round(sma_index2[2],3)
  names(l2)[i] <- sma_names[i]
}
l2[['AR1']] <- c('MAD',
                 round(accuracy(forecast(ar(values[1:81],aic = FALSE, order.max = 1),3))[1],2),
                 'RMSE',
                 round(accuracy(forecast(ar(values[1:81],aic = FALSE, order.max = 1),3))[2],2))
