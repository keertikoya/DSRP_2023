library(janitor)
library(tidyr)
library(dplyr)

# categorical - on_thyroxine (whether patient is on thyroxine (bool))
# numeric - age (int)

## compare the age of patients on and not on thyroxine
# null: avg age of patients on thyroxine is same as avg of patients not on thyroxine
# alternate: avg age of patients on thyroxine is different from avg age of patients not on thyroxine

data <- read.csv("data/thyroidDF.csv")

data_thyroxine <- data |> filter(species == "Human", age>0)
on_thyr <- on_thyroxine |> filter(on_thyroxine == "t")
not_on_thyr <- on_thyroxine |> filter(on_thyroxine == "f")

t.test(males$mass, females$mass, paired = F, alternative = "two.sided")
# p value is 0.06
# not significant, failed to reject null hypothesis


