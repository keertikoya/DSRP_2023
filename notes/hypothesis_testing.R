## t-Tests ####

## compare the mass of male and female starwars characters
# null: avg mass of M and F is the same
# alternate: avg mass of M and F is different

swHumans <-starwars |> filter(species == "Human", mass>0)
males <- swHumans |> filter(sex == "male")
females <- swHumans |> filter(sex == "female")

t.test(males$mass, females$mass, paired = F, alternative = "two.sided")
# p value is 0.06
# not significant, failed to reject null hypothesis

## ANOVA ####
iris

anova_results <- aov(Sepal.Length ~ Species, iris)

# are any groups different from each other?
summary(anova_results)

# which ones?
TukeyHSD(anova_results)

# is there a significant difference in the mean petal lengths or widths by species?
anova_results <- aov(Petal.Length ~ Species, iris)
summary(anova_results)
TukeyHSD(anova_results)

# Starwars
library(dplyr)
library(ggplot2)

head(starwars)
unique(starwars$species)

# which 3 species are the most common?
top3species <- starwars |>
  summarize(.by = species,
            count = sum(!is.na(species))) |>
  slice_max(count, n = 3)

top3species

sw_top3species <- starwars |>
  filter(species %in% top3species$species)

sw_top3species

# is there a significant different in the mass of each of the top 3 species?
anova_results <- aov(mass ~ species, starwars)
summary(anova_results)
TukeyHSD(anova_results)
# no — all the p values are close to 1


# is there a significant different in the height of each of the top 3 species?
anova_results <- aov(height ~ species, sw_top3species)
summary(anova_results)
TukeyHSD(anova_results)
# no — all the p values are close to 1


## Chi-Squared ####

# to do a chi-square, you should have at least 10 in each group

t <- table(starwars$species, starwars$homeworld)
chisq.test(t) # theres not enough data to actually run this, but this is the general format


mpg
# contingency table of year and drv

t <- table(mpg$year, mpg$drv)
chisq_result <- chisq.test(t)
chisq_result$p.value
chisq_result$residuals
# p>0.05 so insignificant

install.packages("corrplot")
library(corrplot)

corrplot(chisq_result$residuals)


# chi-squared full analysis
heroes <- read.csv("data/super_hero_powers.csv")
head(heroes)
names(heroes)

# clean data
heroes_clean <- heroes |>
  filter(Alignment != "-",
         Gender != "-")
heroes$Gender

# plot the counts of alignment and gender
ggplot(heroes_clean, aes(x = Gender, y = Alignment)) +
  geom_count() +
  theme_minimal()

# make contingency table
t <- table(heroes_clean$Alignment, heroes_clean$Gender)
t

# chi squared test
chi <- chisq.test(t)
chi$p.value
chi$residuals

corrplot(chisq_result$residuals, is.cor = F)



