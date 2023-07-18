## Unsupervised Learning ####
# Principal Component Analysis ####
head(iris)

## remove any non-numeric variables
iris_num <- select(iris, -Species)
iris_num

## do PCA
pcas <- prcomp(iris_num)
pcas
# trying to reduce in each principal component (PC)

## do PCA
pcas <- prcomp(iris_num, scale. = T)
summary(pcas)
# ordered from most imp to least (highest prop of var to lowest)
# pc1 and pc2 make up ~96 percent of variance
pcas$rotation

## get the x values of PCAs and make it a data frame
pca_vals <- as.data.frame((pcas$x))
pca_vals$Species <- iris$Species

ggplot(pca_vals, aes(PC1, PC2, color = Species)) +
  geom_point() +
  theme_minimal()



## Supervised Machine Learning ####

library(dplyr)

## Step 1: collect data
head(starwars)

## Step 2: clean and process data
# get rid of NAs
# only use na.omit when you have specifically selected for the vars you want to include in the model
noNAs <- na.omit(starwars)

noNAs <- filter(starwars, !is.na(mass), !is.na(height))

# replace with means
replaceWithMeans <- mutate(starwars,
                           mass = ifelse(is.na(mass),
                                         mean(mass),
                                         mass))

## encoding categories as factors or integers
# if categorical variable is a character, make it a factor
intSpecies <- mutate(starwars,
                     species = as.integer(as.factor(species)))

# if cat var is already a factor, make it an integer
irisAllNumeric <- mutate(iris,
                         Species = as.integer(Species))
irisAllNumeric

# make a PCA
# calculate correlation
#install.packages("reshape2")
library(reshape2)
library(ggplot2)

irisCors <- irisAllNumeric |>
  cor() |>
  melt() |>
  as.data.frame()

# high correlation?
ggplot(irisCors, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "red", high = "blue", mid = "white",
                       midpoint = 0)

# low correlation?
ggplot(irisAllNumeric, aes(x = Petal.Length, y = Sepal.Length)) +
  geom_point() +
  theme_minimal()

## Step 4: Perform Feature Selection
# choose which variables you want to classify or predict
# choose which vars you want to use as features in your model
# for iris data...
# classify on species (classification) and Predict on Sepal.Length(Regression)

## Step 5: Seperate Data into Testing and Training Sets
# choose 70-85% of data to train on
#install.packages("tidymodels")
library(tidymodels)
library(rsample)

## Set a seed for reproducability
set.seed(71723)

## Regression dataset splits
# create a split
reg_split <- initial_split(irisAllNumeric, prop = .75) # use 75% of data for training


# use the split to form testing a training sets
reg_train <- training(reg_split)
reg_test <- testing(reg_split)

## classification dataset splits (using iris instead of irisAllNumeric)
class_split <- initial_split(iris, prop = .75)

class_train <- training(class_split)
class_test <- testing(class_split)
class_test


## Steps 6 & 7: Choose a ML model and train it
# Linear Regression ####
#install.packages("parsnip")
library(parsnip)

lm_fit <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression") |>
  fit(Sepal.Length ~ Petal.Length + Petal.Width + Species + Sepal.Width,
      data = reg_train)

lm_fit$fit
summary(lm_fit$fit)

## Logistic Regression ####
# for log regression,
# 1. filter data to only 2 groups in cat var of interest
#2. make the cat var a factor
# 3. make your training and testing splits

# for our purposes, we are going to filter test and training (dont do this)
binary_test_data <- filter(class_test, Species %in% c("setosa","versicolor"))
binary_train_data <- filter(class_train, Species %in% c("setosa","versicolor"))

# build the model
log_fit <- logistic_reg() |>
  set_engine("glm") |>
  set_mode("classification") |>
  fit(Species ~ Petal.Width + Petal.Length + ., data = binary_train_data)

log_fit$fit
summary(log_fit$fit)


## Boosted Decision Trees ####
#install.packages("xgboost")

boost_reg_fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("regression") |>
  fit(Sepal.Length ~ ., data = reg_train)

boost_reg_fit$fit$evaluation_log

# classification
# use "classification" as the mode, and use Species as the predictor (independent) variable
# use class_train as the data

boost_class_fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("classification") |>
  fit(Species ~ ., data = class_train)

boost_class_fit$fit$evaluation_log

## Random Forest ####
# regression

#install.packages("ranger")

forest_reg_fit <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("regression") |>
  fit(Sepal.Length ~ ., data = reg_train)

forest_reg_fit$fit

forest_class_fit <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("classification") |>
  fit(Species ~ ., data = class_train)

forest_class_fit$fit

## Step 8: Evaluate Model Performance on Test Set
# calc errors for regression
library(yardstick)
#lm_fit, boost_reg_fit, forest_reg_fit
reg_results <- reg_test

reg_results$lm_pred <- predict(lm_fit, reg_test)$.pred
reg_results$boost_pred <- predict(boost_reg_fit, reg_test)$.pred
reg_results$forest_pred <- predict(forest_reg_fit, reg_test)$.pred

yardstick::mae(reg_results, Sepal.Length, lm_pred)
yardstick::mae(reg_results, Sepal.Length, boost_pred)
yardstick::mae(reg_results, Sepal.Length, forest_pred)


# calc accuracy for classification models
#install.packages("Metrics")
library(Metrics)

class_results <- class_test

class_results$lm_pred <- predict(log_fit,class_test)$.pred_class
class_results$boost_pred <- predict(boost_class_fit, class_test)$.pred_class
class_results$forest_pred <- predict(forest_class_fit, class_test)$.pred_class

f1(class_results$Species, class_results$log_pred)
f1(class_results$Species, class_results$boost_pred)
f1(class_results$Species, class_results$forest_pred)








