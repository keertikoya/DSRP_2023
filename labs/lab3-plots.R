# Imports ####

library (ggplot2)
data <- read.csv("data/thyroidDF.csv")

age <- data$age

data <- filter(data, age < 100) # removes outliers
grep("65526",age) # making sure outliers are gone

# one var
ggplot(data = data, aes(x = age)) +
  geom_histogram(fill = "maroon3") +
  labs (title = "Distribution of Age")

# numeric vs categorical
ggplot(data = data, aes(x = sick, y = age)) +
  geom_violin(aes(fill = sick)) + geom_boxplot(width = 0.3) +
  labs (title = "Age vs Sick") +
  scale_fill_manual(values = c("lightcoral", "slateblue"))

# numeric vs other numeric + coloring by sick
ggplot(data = data, aes(x = age, y = TBG, color = sick)) +
  geom_point() +
  labs (title = "Age vs TBG level") +
  scale_color_manual(values = c("plum", "maroon3"))