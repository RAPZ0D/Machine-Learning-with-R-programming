# K Means Clustering on the IRIS dataset 
data(iris)
head(iris)

str(iris)

summary(iris)

# Scatterplot 1 
library(ggplot2)
random_colors <- sample(colors(), length(unique(iris$Species)))

# Plot with custom shapes and random colors
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species, shape = Species)) +
  geom_point(alpha = 0.8, size = 3) +
  scale_color_manual(values = random_colors) +
  scale_shape_manual(values = c(16, 17, 15)) +  # Set custom shapes
  labs(title = "Scatter Plot of Petal Length vs Petal Width",
       x = "Petal Length", y = "Petal Width") +
  theme_minimal()

# K means using elbow method 
library(stats)
library(cluster)

# Scaling the column except the species column
scaled_iris <- scale(iris[, -5])

# Determini g the optimal number of clusters 
wss <- numeric(10)
for (i in 1:10) {
  wss[i] <- sum(kmeans(scaled_iris, centers = i)$withinss)
}
plot(1:10, wss, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares",
     main = "Elbow Method", col = "blue", pch = 19)

# Choosing the optimal K from the above graph the optimal i used is 3 
optimal_k <- 3
print(optimal_k)
#Running the K means algorithm 
kmeans_result <- kmeans(iris[, -5], centers = optimal_k, nstart = 20)

# Final Visuals 
clusplot(iris[, -5], kmeans_result$cluster, color = TRUE, shade = TRUE,
         labels = 1, lines = 0, main = 'Clusters of Iris Data')

# K means using silhouette method 
# Determining the optimal clusters 
sil_width <- c(NA)
for(i in 2:10) {
  km <- kmeans(iris[, -5], centers = i, nstart = 20)
  silhouette_width <- silhouette(km$cluster, dist(iris[, -5]))
  sil_width[i] <- mean(silhouette_width[, "sil_width"])
}
plot(2:10, sil_width[-1], type = "b", xlab = "Number of Clusters", ylab = "Average Silhouette Width",
     main = "Silhouette Method", col = "#dd44f0")

# With this method the optimal is 5 clusters 
optimal_k <- 5
kmeans_result <- kmeans(iris[, -5], centers = optimal_k, nstart = 20)
clusplot(iris[, -5], kmeans_result$cluster, color = TRUE, shade = TRUE,
         labels = 1, lines = 0, main = 'Clusters of Iris Data')


