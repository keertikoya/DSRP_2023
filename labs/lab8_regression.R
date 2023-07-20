library(tidymodels)
library(dplyr)
library(reshape2)
library(rsample)
library(Metrics)
library(parsnip)
library(yardstick)
library(ggplot2)


# Data ####
data <- read.csv("data/thyroidDF.csv")
head(data)

# replace with means
data$TSH[is.na(data$TSH)]<-mean(data$TSH,na.rm=TRUE)
data$T3[is.na(data$T3)]<-mean(data$T3,na.rm=TRUE)
data$TT4[is.na(data$TT4)]<-mean(data$TT4,na.rm=TRUE)
data$T4U[is.na(data$T4U)]<-mean(data$T4U,na.rm=TRUE)
data$FTI[is.na(data$FTI)]<-mean(data$FTI,na.rm=TRUE)

data_new <- data |> select(TSH, T3, TT4, T4U, FTI)


# PCA ####
pcas <- prcomp(data_new)

pcas <- prcomp(data_new, scale. = T)
summary(pcas)
pcas$rotation
pca_vals <- as.data.frame((pcas$x))
pca_vals$FTI <- data$FTI

ggplot(pca_vals, aes(PC1, PC2, color = FTI)) +
  geom_point() +
  theme_minimal()


# tile plot
dataCors <- data_new |>
  cor() |>
  melt() |>
  as.data.frame()

ggplot(dataCors, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "red", high = "blue", mid = "white",
                       midpoint = 0)


# Linear Regression ####
set.seed(71723)

# create a split
split <- initial_split(data_new, prop = .75) # use 75% of data for training
train <- training(split)
test <- testing(split)

# linear regression model
lm_fit <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression") |>
  fit(FTI ~ TSH + T3 + TT4 + T4U,
      data = train)

lm_fit$fit
summary(lm_fit$fit)


# Lin Reg Error ####
results <- test
results$lm_pred <- predict(lm_fit, test)$.pred
yardstick::mae(results, FTI, lm_pred)
yardstick::rmse(results, FTI, lm_pred)


# Boosted Decision Tree ####
boost_fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("regression") |>
  fit(FTI ~ TSH + T3 + TT4 + T4U,
      data = train)

boost_fit$fit$evaluation_log

# Boost Tree Error ####
results <- test
results$boost_pred <- predict(boost_fit, results)$.pred
yardstick::mae(results, FTI, boost_pred)
yardstick::rmse(results, FTI, boost_pred)


# Random Forest ####
forest_fit <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("regression") |>
  fit(FTI ~ TSH + T3 + TT4 + T4U,
      data = train)

forest_fit$fit

# Random Forest Error ####
results <- test
results$forest_pred <- predict(forest_fit, results)$.pred
yardstick::mae(results, FTI, forest_pred)
yardstick::rmse(results, FTI, forest_pred)









