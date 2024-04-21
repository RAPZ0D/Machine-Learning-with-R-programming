# Neural Network Project 

df <- read.csv('bank_note_data.csv')
head(df)

str(df)

summary(df)

unqiue(df$Class)

# Load required libraries
library(neuralnet)
library(caTools)
library(ggplot2)

# Perform train-test split
set.seed(101) # Set seed for reproducibility
split <- sample.split(df$Class, SplitRatio = 0.7)
train <- subset(df, split == TRUE)
test <- subset(df, split == FALSE)

# Define formula
f <- as.formula("Class ~ .")

# Train the neural network model
nn_model <- neuralnet(f, data = train, hidden = c(10), linear.output = TRUE)

# Make predictions on the test set
predicted_values <- predict(nn_model, test)
predicted_classes <- ifelse(predicted_values > 0.5, 1, 0)

# Calculate accuracy
accuracy <- mean(predicted_classes == test$Class)
cat("Accuracy:", accuracy, "\n")

# Calculate Mean Squared Error
mse <- mean((predicted_values - test$Class)^2)
cat("Mean Squared Error:", mse, "\n")

# Visualize predicted vs actual values
prediction_df <- data.frame(Predicted = predicted_values, Actual = test$Class)
print(prediction_df)

#Visuals
ggplot(prediction_df, aes(x = Actual, y = Predicted)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("Neural Network: Predicted vs Actual Values") +
  xlab("Actual Values") +
  ylab("Predicted Values")

#Boxplot
ggplot(prediction_df, aes(x = factor(Actual), y = Predicted, fill = factor(Actual))) +
  geom_boxplot() +
  ggtitle("Neural Network: Predicted Values by Actual Classes") +
  xlab("Actual Classes") +
  ylab("Predicted Values") +
  scale_fill_manual(values = c("lightblue", "lightgreen"))

#Violin Plot 
ggplot(prediction_df, aes(x = factor(Actual), y = Predicted, fill = factor(Actual))) +
  geom_violin(trim = FALSE, aes(fill = factor(Actual))) +
  scale_fill_manual(values = c("yellow", "purple")) +
  ggtitle("Neural Network: Predicted Values by Actual Classes") +
  xlab("Actual Classes") +
  ylab("Predicted Values")

