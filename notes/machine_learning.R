## Unsupervised Learning ####
## Principal Component Analysis
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





