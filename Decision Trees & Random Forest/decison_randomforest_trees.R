# Decision Trees and Random Forest 
library(rpart)
library(randomForest)

data("kyphosis")
head(kyphosis)

str(kyphosis)

printcp(kyphosis)

# Splitting data into training and testing sets
set.seed(123) # for reproducibility
train_index <- sample(1:nrow(kyphosis), 0.7 * nrow(kyphosis))
train_data <- kyphosis[train_index, ]
test_data <- kyphosis[-train_index, ]

# Build the decision tree model
tree_model <- rpart(Kyphosis ~ ., data = train_data)
# Print the decision tree
print(tree_model)

# Plot the decision tree
plot(tree_model, uniform = TRUE, margin = 0.1)
text(tree_model, use.n = TRUE, cex = 0.6)

# Building the random forest model
rf_model <- randomForest(Kyphosis ~ ., data = train_data)
# Printing the random forest model
print(rf_model)
# Plot the variable importance
varImpPlot(rf_model)

# Predict using the decision tree model
tree_pred <- predict(tree_model, newdata = test_data, type = "class")
# Predict using the random forest model
rf_pred <- predict(rf_model, newdata = test_data)
# Evaluate the models
# For example, accuracy for the decision tree model
accuracy_tree <- mean(tree_pred == test_data$Kyphosis)
print(accuracy_tree)

#Present absent tree
library(rpart.plot)
prp(tree_model)
