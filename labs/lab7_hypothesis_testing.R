library(janitor)
library(tidyr)
library(dplyr)

## LAB PART 1 ####

## compare the age of patients on and not on thyroxine

# categorical - on_thyroxine (whether patient is on thyroxine (bool))
# numeric - age (int)

# null: avg age of patients on thyroxine is same as avg of patients not on thyroxine
# alternate: avg age of patients on thyroxine is different from avg age of patients not on thyroxine
# paired, two-tailed

data <- read.csv("data/thyroidDF.csv")

# data_thyroxine <- data |> filter(species == "Human", age>0)
on_thyr <- data |> filter(on_thyroxine == "t")
not_on_thyr <- data |> filter(on_thyroxine == "f")

t.test(on_thyr$age, not_on_thyr$age, paired = F, alternative = "two.sided")
# p value is 0.0859 (not significant, failed to reject null hypothesis)

# There is not a significant difference in the mean age between 
# groups of patients on thyroxine and patients not on thyroxine.


## LAB PART 2 ####

# Since my dataset does not have any categorical variables with >2 groups, I will be using the starwars dataset.

head(species)
# species (Human, Droid, Gungan) vs height

# null: avg height of humans = avg height of droids = avg height of Gungans
# alternate: avg height of humans != avg height of droids != avg height of Gungans

new_sw <- filter(starwars, species == c("Human","Droid","Gungan"))

anova_results <- aov(height ~ species, new_sw)
summary(anova_results)
TukeyHSD(anova_results)

# Gungan-Droid: p = 0.0490396 (There is a significant difference in the mean height between Gungans and Droids.)
# Human-Gungan: p = 0.0425018 (There is a significant difference in the mean height between Human and Gungans)
# Human-Droid: p = 0.5316805 (There is a not significant difference in the mean height between Humans and Droids.)


## LAB PART 3 ####

# two categorical variables: on_thyroxine and thyroid_surgery

# null: There is a significant association between on_thyroxine and thyroid_surgery.
# alternate: There is not a significant association between on_thyroxine and thyroid_surgery

t <- table(data$on_thyroxine, data$thyroid_surgery)
chisq_result <- chisq.test(t)
chisq_result$p.value
chisq_result$residuals

corrplot(chisq_result$residuals, is.cor = F)

# p-value: 0.1042068
# There is not a significant association between on_thyroxine and thyroid_surgery based on the chi-squared test (p-value = 0.1042068).

