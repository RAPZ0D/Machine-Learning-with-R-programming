# Neural Nets 

library(MASS)

set.seed(101)
data <- Boston

head(data)

summary(data)

any(is.na(data)) # No null values if the output is False 

# Building the Neural Network 
library(neuralnet)
library(ggplot2)

# Compute scaling parameters
maxs <- apply(data, 2, max)
mins <- apply(data, 2, min)

print(maxs)
print(mins)
# Scale the data
scaled <- as.data.frame(scale(data, center = mins, scale = maxs - mins))

print(scaled)

# Split the data into training and testing sets
library(caTools)
split <- sample.split(scaled$medv, SplitRatio = 0.70)
train <- subset(scaled, split == TRUE)
test <- subset(scaled, split == FALSE)
print(train)
print(test)

# Define the formula for neural network
n <- names(train)
f <- as.formula(paste("medv ~", paste(n[!n %in% "medv"], collapse = " + ")))

# Train the neural network model
nn <- neuralnet(f, data = train, hidden = c(5, 3), linear.output = TRUE)

# Compute predictions on the test set
predicted.nn.values <- compute(nn, test[1:13])

# Convert back to non-scaled predictions
true.predictions <- predicted.nn.values$net.result * (max(data$medv) - min(data$medv)) + min(data$medv)
test.r <- (test$medv) * (max(data$medv) - min(data$medv)) + min(data$medv)

# Calculate Mean Squared Error
MSE.nn <- sum((test.r - true.predictions)^2) / nrow(test)
print(paste("Mean Squared Error (MSE):", MSE.nn))

# Visualize Error
error.df <- data.frame(test.r, true.predictions)

head(error.df)

#Visuals 

library(ggplot2)
ggplot(error.df, aes(x = test.r, y = true.predictions)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("Neural Network: Actual vs Predicted") +
  xlab("Actual Values") +
  ylab("Predicted Values")

