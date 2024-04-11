# Support Vector Machine 
data(iris)

head(iris)

str(iris)

summary(iris)

set.seed(123)

# Creating a Vector for indices 
indices <- sample(1:nrow(iris), nrow(iris)*0.7)

#splitting the data
train_data <- iris[indices,]
test_data <- iris[-indices,]

print(train_data)

# Locading the library to perform SVM 
library(e1071)

#Training the model 
svm_model <- svm(Species ~ ., data =train_data, kernel ='radial')

# PRedictions using SVM
svm_predictions <- predict(svm_model, test_data)

#Evalutaions 
accuracy <- mean(svm_predictions == test_data$Species)
print(paste("Accuracy: ", accuracy))

# Actual vs Predicted Values 
results <- data.frame(Actual= test_data$Species, Predicted = svm_predictions)
print(results)
