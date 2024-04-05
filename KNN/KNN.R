# K nearest Neighbors 
library(ISLR)

data(Caravan)
head(Caravan)

str(Caravan)

summary(Caravan)

# Checking for null values 
any(is.na(Caravan))

#Splitting the Data to train and test
set.seed(123)
train_index <- sample(1:nrow(Caravan), 1000)
train_data <- Caravan[train_index, ]
test_data <- Caravan[-train_index, ]

print(train_data)
print(test_data)

unique(Caravan$Purchase)
# Converting the Purchase column to numeric 
train_data$Purchase <- ifelse(train_data$Purchase == "Yes", 1, 0)
test_data$Purchase <- ifelse(test_data$Purchase == "Yes", 1, 0)

#Scaling the Data
train_data_scaled <- scale(train_data[, -86])  
test_data_scaled <- scale(test_data[, -86]) 
# Impute missing values with mean
train_data_scaled[is.na(train_data_scaled)] <- mean(train_data_scaled, na.rm = TRUE)
test_data_scaled[is.na(test_data_scaled)] <- mean(test_data_scaled, na.rm = TRUE)


#Training the data 
library(class)
k <- 5  # Number of neighbors
knn_model <- knn(train = train_data_scaled, test = test_data_scaled, cl = train_data$Purchase, k = k)

# Confusion matrix
conf_matrix <- table(test_data$Purchase, knn_model)
print(conf_matrix)

# Calculate accuracy
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
print(accuracy)


# Plot
library(ggplot2)
library(tidyr)
# Convert the confusion matrix to a dataframe
conf_matrix_df <- as.data.frame(conf_matrix)

# Add rownames as a column named 'actual'
conf_matrix_df$actual <- rownames(conf_matrix_df)

# Reshape the dataframe to long format
conf_matrix_df_long <- gather(conf_matrix_df, key = "predicted", value = "count", -actual)

# Convert the 'count' variable to numeric
conf_matrix_df_long$count <- as.numeric(conf_matrix_df_long$count)

# Plot the confusion matrix
ggplot(conf_matrix_df_long, aes(x = actual, y = predicted, fill = count)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "white", high = "steelblue") +
  geom_text(aes(label = count), color = "black") +
  labs(title = "Confusion Matrix", x = "Actual", y = "Predicted")

# Elbow Plot
# Initialize error_rate vector
error_rate <- numeric(length(x_values))

# Calculate error rate for different k values
for (i in seq_along(x_values)) {
  knn_model <- knn(train = train_data_scaled, test = test_data_scaled, cl = train_data$Purchase, k = x_values[i])
  conf_matrix <- table(test_data$Purchase, knn_model)
  error_rate[i] <- 1 - sum(diag(conf_matrix)) / sum(conf_matrix)
}

# Plot with customizations
plot(x_values, error_rate, type = "b", xlab = "Number of Neighbors (k)", ylab = "Error Rate", main = "Elbow Method", col = "red", xaxt = "n", lty = 2)
axis(1, at = x_values, labels = x_values)

# Add points with black dots
points(x_values, error_rate, col = "black", pch = 19)



