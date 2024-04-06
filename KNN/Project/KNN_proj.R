#KNN Project 
#Using the iris library 
data(iris)
head(iris)

str(iris)

unique(iris$Species)

# Converting the Species into Factor
iris$Species <- as.factor(iris$Species)
print(iris$Species)

# Splitting the data into training and testing sets
set.seed(123) # for reproducibility
train_indices <- sample(1:nrow(iris), 0.7*nrow(iris)) # 70% training data
train_data <- iris[train_indices, ]
test_data <- iris[-train_indices, ]

# Standardize numeric features
numeric_features <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")
train_data[numeric_features] <- scale(train_data[numeric_features])
test_data[numeric_features] <- scale(test_data[numeric_features])

# Load the class package for KNN
library(class)
k <- 3
# Fit the KNN model
knn_model <- knn(train = train_data[, numeric_features], test = test_data[, numeric_features], cl = train_data$Species, k = k)

#Predictions 
prediction_table <- data.frame(Actual = test_data$Species, Predicted = knn_model)
print(prediction_table)

#Evaluations
# Compute accuracy
accuracy <- mean(knn_model == test_data$Species)
print(paste("Accuracy:", accuracy))

# Compute confusion matrix
library(caret)
confusion_matrix <- table(Actual = test_data$Species, Predicted = knn_model)
print("Confusion Matrix:")
print(confusion_matrix)

#Visualizations
#Elbow Plot for optimum k value
library(class)
library(ggplot2)

# Set up empty vectors to store accuracy values
k_values <- c(1:20)
accuracy_values <- numeric(length(k_values))

# Loop through different values of k and compute accuracy
for (i in 1:length(k_values)) {
  knn_model <- knn(train = train_data[, numeric_features], test = test_data[, numeric_features], cl = train_data$Species, k = k_values[i])
  accuracy_values[i] <- mean(knn_model == test_data$Species)
}

# Create a data frame for plotting
accuracy_df <- data.frame(k = k_values, Accuracy = accuracy_values)

# Plot the elbow plot
ggplot(data = accuracy_df, aes(x = k, y = Accuracy)) +
  geom_line(color = "black", linetype = "dotted") +
  geom_point(color = "red") +
  labs(title = "Elbow Plot for Optimal k-value Selection",
       x = "k (Number of Neighbors)",
       y = "Accuracy")

#Scatterplot
optimal_k <- which.max(accuracy_values)
knn_model <- knn(train = train_data[, numeric_features], test = test_data[, numeric_features], cl = train_data$Species, k = optimal_k)

# Add predicted labels to the test data
test_data$Predicted_Species <- knn_model

# Plot a scatterplot showing KNN classification
ggplot(data = test_data, aes(x = Petal.Length, y = Petal.Width, color = Predicted_Species)) +
  geom_point() +
  labs(title = "Scatterplot Showing KNN Classification",
       x = "Petal Length",
       y = "Petal Width")

