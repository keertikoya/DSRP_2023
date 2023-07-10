# install required packages
install.packages("ggplot2")
install.packages(c("usethis","credentials"))

# load required packages
library(ggplot2)

ggplot()

# mpg dataset
str(mpg)

# , seperate parameters, + seperates function calls
ggplot(data = mpg, aes(x=hwy, y=cty)) +
  geom_point() +
  labs(x = "highway mpg",
       y = "city mpg",
       title = "car city vs highway mileage")

## HISTOGRAMS
# ggplot(data=dataset,aes(x=column_name)) +
  # geom_histogram()

ggplot(data = mpg, aes(x = hwy)) +
  geom_histogram()

# set numbers of bars with "bins"
ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_histogram(bins = 10)

# set bar width with "binwidth"
ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_histogram(binwidth = 0.25)


## DENSITY PLOT
# ggplot(data = dataset, aes(x = column_name,
# y = after_stat(count)))
#   geom_density()

ggplot(data = mpg, aes(x=hwy)) +
  geom_density()

ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_density()
# y = density not count


## BOXPLOT
# ggplot(data = dataset, aes(x = column_name, y = opt_category)) +
#   geom_boxplot()

ggplot(data = mpg, aes(x = hwy)) +
  geom_boxplot()

ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_boxplot()

ggplot(data = iris, aes(y = Sepal.Length)) +
  geom_boxplot()

ggplot(data = iris, aes(x = Sepal.Length, y = Species)) +
  geom_boxplot()
# can see median/range of all three species lengths


## VIOLIN PLOT
ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_violin()


## VIOLIN AND BOX PLOTS
ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_violin(color = "orange", fill = "lightblue") + 
  geom_boxplot(width = 0.2, fill = NA)


## BAR PLOTS
ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_bar(stat = "summary",
           fun = "mean")
# to use a numeric x var, you need stat = "summary

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_bar(stat = "summary",
           fun = "mean",
           color = "purple", fill = "purple") +
           labs(title = "Species vs Sepal Length")

ggplot(data = iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_bar(stat = "summary",
           fun = "mean") +
  labs(title = "Species vs Sepal Length")
# if setting color based on a variable, it HAS to be wrapped in an aes call


## SCATTER PLOTS
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point()

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_jitter()

ggsave("plots/Example Jitter Plot.png")
# saving plots


## LINE PLOTS
ggplot(data = iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_line()

ggplot(data = iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_line(stat = "summary", fun = "mean")

ggplot(data = iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point() +
  geom_smooth(se = F) +
  theme_minimal()

# color scales
ggplot(data = iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) +
  geom_point() +
  scale_color_manual(values = c("violet", "lightpink", "red"))

ggplot(data = iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point(aes(color = Species)) +
  scale_color_manual(values = c("violet", "lightpink", "red"))


# factors
mpg$year <- as.factor(mpg$year)

iris$Species <- factor(iris$Species, levels = ("versicolor, setosa, virginica"))





