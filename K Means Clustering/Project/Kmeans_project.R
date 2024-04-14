# K means clustering Project 
# Importing the dataset Red and White Wine 
red_wine <- read.csv("winequality-red.csv", sep = ";")
white_wine <- read.csv("winequality-white.csv", sep = ";")

#Adding a new column called label
red_wine$label <- "red"
white_wine$label <- "white"
head(red_wine)
head(white_wine)

# Merging the dataset 
wine_dataset <- rbind(red_wine,white_wine)
head(wine_dataset)
unique(wine_dataset$label)

str(wine_dataset)

summary(wine_dataset)

# EDA (exploratory data analysis)
library(ggplot2)
# Residual sugar
pl <- ggplot(wine_dataset, aes(x = residual.sugar)) + 
  geom_histogram(aes(fill = label), color = 'black', bins = 50) +
  scale_fill_manual(values = c('#f00244', '#eae4cc')) + 
  theme_bw()

print(pl)

# Alcohol level
pl_alcohol <- ggplot(wine_dataset, aes(x = alcohol)) + 
  geom_histogram(aes(fill = label), color = 'black', bins = 50) +
  scale_fill_manual(values = c('#f00244', '#eae4cc')) + 
  theme_bw()

print(pl_alcohol)

# Quality 
pl_quality <- ggplot(wine_dataset, aes(x = quality)) + 
  geom_histogram(aes(fill = label), color = 'black', bins = 20, alpha = 0.7) +
  scale_fill_manual(values = c('#f00244', '#eae4cc')) + 
  labs(title = "Distribution of Wine Quality Ratings", x = "Quality", y = "Frequency") +
  theme_minimal()

print(pl_quality)

#Perfroming K means clustering 
library(cluster)
wine_features <- wine_dataset[, !names(wine_dataset) %in% c("label")]
wine_dataset$label <- as.factor(wine_dataset$label)
scaled_features <- scale(wine_features)

#Elbow plot 
wcss <- numeric(10)
for (k in 1:10) {
  kmeans_model <- kmeans(scaled_features, centers = k)
  wcss[k] <- kmeans_model$tot.withinss
}

elbow_plot <- ggplot(data.frame(k = 1:10, WCSS = wcss), aes(x = k, y = WCSS)) +
  geom_line() +
  geom_point() +
  labs(title = "Elbow Method for Optimal k",
       x = "Number of Clusters (k)",
       y = "Within-Cluster Sum of Squares (WCSS)") +
  theme_minimal()

print(elbow_plot)

# Selecting the optimal k value 
optimal_k <- 2  
kmeans_model <- kmeans(scaled_features, centers = optimal_k)

# Cluster visualization 
clusplot(scaled_features, kmeans_model$cluster, color = TRUE, shade = TRUE,
         labels = 1, lines = 0, main = paste("Clusters of Wine Dataset (k =", optimal_k, ")"))
