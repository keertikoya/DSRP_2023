## Note: This file was my initial attempt at the assignment. 
##       The file titled lab8_regression.R has my completed and working code.

library(tidymodels)
library(dplyr)
library(reshape2)
library(ggplot2)
library(rsample)
library(Metrics)


# Collect data ####
data <- read.csv("data/thyroidDF.csv")
head(data)

# PCA ####

## remove any non-numeric variables
data_num <- select(data, age, TSH, T3, TT4, T4U, FTI, TBG)
data_num

## do PCA
pcas <- prcomp(data_num)
pcas
# trying to reduce in each principal component (PC)

## do PCA
pcas <- prcomp(data_num, scale. = T)
summary(pcas)
# ordered from most imp to least (highest prop of var to lowest)
# pc1 and pc2 make up ~96 percent of variance
pcas$rotation

## get the x values of PCAs and make it a data frame
pca_vals <- as.data.frame((pcas$x))
pca_vals$thyroid_surgery <- data$thyroid_surgery

ggplot(pca_vals, aes(PC1, PC2, color = thyroid_surgery)) +
  geom_point() +
  theme_minimal()



# Clean & process data ####

# replace with means

data$TSH[is.na(data$TSH)]<-mean(data$TSH,na.rm=TRUE)
data$T3[is.na(data$T3)]<-mean(data$T3,na.rm=TRUE)
data$TT4[is.na(data$TT4)]<-mean(data$TT4,na.rm=TRUE)
data$T4U[is.na(data$T4U)]<-mean(data$T4U,na.rm=TRUE)
data$FTI[is.na(data$FTI)]<-mean(data$FTI,na.rm=TRUE)
data$TBG[is.na(data$TBG)]<-mean(data$TBG,na.rm=TRUE)


noNAs <- filter(data, 
                !is.na(thyroid_surgery))

data_new <- noNAs |> select(TSH, T3, TT4, T4U, FTI, TBG, thyroid_surgery) |>
  mutate(thyroid_surgery = as.integer(as.factor(thyroid_surgery)))
#data_new$thyroid_surgery <- factor(data_new$thyroid_surgery)

# correlation
dataCors <- data_new |>
  cor() |>
  melt() |>
  as.data.frame()


# Visualize data ####
ggplot(dataCors, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "red", high = "blue", mid = "white",
                       midpoint = 0)

ggplot(data_new, aes(x = TSH, y = thyroid_surgery)) +
  geom_point() +
  theme_minimal()

## setting a seed for reproducability
set.seed(71723)

# create a split
split <- initial_split(data_new, prop = .75) # use 75% of data for training
train <- training(split)
test <- testing(split)


## Logistic Regression ####

# build the model

log_fit <- logistic_reg() |>
  set_engine("glm") |>
  set_mode("classification") |>
  fit(thyroid_surgery ~ TSH + T3 + TT4 + T4U + FTI + TBG, 
      data = train)

log_fit$fit
summary(log_fit$fit)

# F1 score
results <- test
results$log_pred <- predict(log_fit, test)$.pred_class
f1(results$thyroid_surgery, results$log_pred)

#install.packages("caret")
library(caret)

actual <- factor(results$thyroid_surgery, levels = c('t','f'))
pred <- factor(results$log_pred, levels = c('t','f'))
confusionMatrix(pred, actual, mode = "everything", positive="t")







