# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())
#Set work directory
setwd("~/Desktop/Uwaterloo/719/A02")

# Library packages
if(!require(readxl)){install.packages("readxl")}
library(readxl)
if(!require(reshape2)){install.packages("reshape2")}
library(reshape2)

# Q1
data <- read_excel("Assignment2_Data.xlsx")

# check months
for (i in names(data[grepl('2017',colnames(data))])) {
  for (j in strsplit(i, " ")[[1]][3])
    print(j)
}

flavors = c("choco","hazelnut","coco","green","caramel",
            "vanilla","pina","coffee","almond","waffle","bean")
new_flavors = c("Chocolate","Hazelnut","Coconut","Green tea","Caramel",
                "Vanilla","Pina colada","Coffee","Almond","Waffle cone","Bean")
l2 <- list()
for (i in seq_along(flavors)) {
  # 6:188 are date columns
  l2[[i]] <- data[grepl(flavors[i],tolower(data$Product)),][,c(6:188)]
  # rename by product category
  names(l2)[i] <- new_flavors[i]
  # creat a new list 
  l3 <- list()
  for (j in seq(l2)) {
    # store aggreate sum into l3
    l3[[j]] <- apply(l2[[j]], MARGIN = 2, FUN = sum)
    # rename 
    names(l3)[j] <- new_flavors[j]
  }
  for (k in seq_along(l3)) {
    # assign each category's summary data into global env
    assign(names(l3)[[k]],l3[[k]],.GlobalEnv)
    }
}

months <- c(rep('Apr',30),rep('May',31),rep('Jun',30),rep('Jul',31),
            rep('Aug',31),rep('Sep',30))
new_data <- data.frame(mget(c("months","Chocolate","Hazelnut","Coconut","Green tea","Caramel",
                              "Vanilla","Pina colada","Coffee","Almond","Waffle cone","Bean")))
new_data <- aggregate(cbind(new_data[,c(2:12)]),by=list(Months = new_data$months), FUN = sum)
new_data2 <- melt(new_data)
new_data2$Categories <- as.factor(c(rep('level1',30), rep('level2',36)))


# Q1.category vs Apr:Sep
l4 <- list()
for (i in unique(months)) {
  d <- new_data2[new_data2$Months == i,]
  l4[[i]] <- t.test(d$value ~ d$Categories, data = d)
}
for (j in seq(names(l4))) {
  for (k in names(l4[[j]][3])) {
    print(names(l4[j]))
    print(l4[[j]][k])
  }
}

# Q1.category 1 vs catgeory 2 (2000)
t.test(new_data2$value ~ new_data2$Categories, data = new_data2)

# Q2.identity vs. sales
l5 <- list()
for (i in seq_along(flavors)) {
  l5[[i]] <- data[grepl(flavors[i],tolower(data$Product)),][,c(2,6:188)]
  l5[[i]] <- as.data.frame(melt(l5[[i]]))
  names(l5)[i] <- new_flavors[i]
  l5[[i]][,'Flavors'] <- new_flavors[i]
}
q2_data <-do.call(rbind,l5)

q2_data$Categories <- ifelse(as.factor(q2_data$Flavors) %in% c("Chocolate","Hazelnut","Coconut","Green tea","Caramel"),
                               "level1","level2")

plot_sales <- list()
# tourists,students,staff 
# two-levels
for (i in unique(q2_data$identity)) {
  library(dplyr)
  library(ggplot2)
  d <- q2_data %>% filter(identity == i) %>%
    group_by(variable,Categories) %>%
    summarise(value = sum(value))
  plot_sales[[i]] <- ggplot(d,aes(variable,value,group=Categories)) + 
    geom_line(aes(color=Categories)) +
    theme(axis.text.x = element_blank())
    ggtitle(paste("Identity:",i))
}
do.call(grid.arrange,plot_sales)
