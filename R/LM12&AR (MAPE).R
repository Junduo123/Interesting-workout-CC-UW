# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())
#Set work directory
setwd("~/Desktop/Uwaterloo/719/A04")

# Library packages
if(!require(readxl)){install.packages("readxl")}
library(readxl)

if(!require(smooth)){install.packages("smooth")}
library(smooth)

data <- read_excel("Assignment4_Data.xlsx")

# Q1
summary(aov(data$Actual~data$DOW),data = data)
TukeyHSD(aov(data$Actual~data$DOW),data = data)

# Q2

# set model
formula <- list(); model <- list()
for (i in 1:1) {
  #LM, LM(consider DOW), AR(14)
  formula[[i]] <- paste0(data[1:round(0.9*nrow(data)),19],' ~ ',data[1:round(0.9*nrow(data)),5])
  model[[i]] <- lm(formula[[i]])
  formula[[i+1]] <- paste0(formula[[1]],'+',data[1:round(0.9*nrow(data)),2])
  model[[i+1]] <- lm(formula[[i+1]])
  model[[i+2]] <- ar(data[1:round(0.9*nrow(data)),19],aic = FALSE, order.max = 14)
}

testing_data <- data[-(1:round(0.9*nrow(data))),c(2,5,19)]
testing_data <- cbind(model.matrix(~testing_data$DOW),testing_data[,c(2,3)])

#forecast
predict_values <- list()
for (i in 1:1) {
  predict_values[[i]] <- model[[1]]$coefficients[1]+model[[1]]$coefficients[2]*testing_data$Actual
  predict_values[[i+1]] <- predict_values[[1]]+
                            model[[2]]$coefficients[3]*testing_data$`testing_data$DOWMon`+
                            model[[2]]$coefficients[4]*testing_data$`testing_data$DOWThu`+
                            model[[2]]$coefficients[5]*testing_data$`testing_data$DOWTue`+
                            model[[2]]$coefficients[6]*testing_data$`testing_data$DOWWed`
  predict_values[[i+2]] <- forecast(ar(data[1:round(0.9*nrow(data)),19],aic = FALSE,order.max = 14),24)['mean']
}

library(forecast)
cat("The MAPE value for LM ignore the impact of the DOM is:",
    mean(abs(predict_values[[1]] - testing_data$Actual)/testing_data$Actual)*100,'\n',
"The MAPE value for LM consider the impact of the DOM is:",
    mean(abs(predict_values[[2]] - testing_data$Actual)/testing_data$Actual)*100,'\n',
"The MAPE value for autoregression model of order 14 is:",
    accuracy(forecast(ar(data[1:round(0.9*nrow(data)),19],aic = FALSE,order.max = 14),24))[5]
)
