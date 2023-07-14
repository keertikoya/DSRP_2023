install.packages("tidyverse")
library(tidyverse)

data<-read.csv("data/thyroidDF.csv")
glimpse(data)
summary(data)

# Raw Data ####
age <- as.numeric(data$age)
age <- data$age
age

mean_age <- mean(age)
med_age <- median(age)

# solving issue of 4 unrealistic age values
max <- max(age)
grep("65526",age)
sorted_age <- rev(sort(age))
age <- sorted_age[5:8172]

range_age <- max(age) - min(age)
var_age <- var(age)
stdev_age <- sd(age)
iqr_age <- IQR(age)

q3_age <- quantile(age, 0.75)
q1_age <- quantile(age, 0.25)
upper <- q3_age + 1.5 * iqr_age
lower <- q1_age - 1.5 * iqr_age

values <- c(age,1,112)
min(values)
max(values)
values[values < lower & values > upper]







