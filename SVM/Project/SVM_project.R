# SVM Project 
df <- read.csv('loan_data.csv')
head(df)

str(df)

summary(df)

unique(df$purpose)
#Converting the purpose column to numerical
value_mapping <- c("debt_consolidation" = 1, 
                   "credit_card" = 2, 
                   "all_other" = 3, 
                   "home_improvement" = 4, 
                   "small_business" = 5, 
                   "major_purchase" = 6, 
                   "educational" = 7)
df$purpose <- value_mapping[df$purpose]
head(df$purpose)

# Converting to factor 
df$credit.policy <- factor(df$credit.policy)
df$inq.last.6mths <- factor(df$inq.last.6mths)
df$delinq.2yrs <- factor(df$delinq.2yrs)
df$pub.rec <- factor(df$pub.rec)
df$not.fully.paid <- factor(df$not.fully.paid)


#EDA 
library(ggplot2)
#Plot 1
pl <- ggplot(df, aes(x = fico)) +
  geom_histogram(aes(fill = not.fully.paid), color = 'black', bins = 40, alpha = 0.7) +
  scale_fill_manual(values = c('green', 'red')) +
  theme_minimal() +
  labs(x = "FICO Score", y = "Frequency", fill = "Loan Status") +
  ggtitle("Distribution of FICO Scores by Loan Status") +
  theme(legend.position = "top")

pl

#plot 2 
pl <- ggplot(df, aes(x = factor(purpose))) +
  geom_bar(aes(fill = not.fully.paid), position = "dodge") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

pl

#Plot 3 
# Boxplot
ggplot(df, aes(x = factor(credit.policy), y = fico)) +
  geom_boxplot(fill = "skyblue", color = "blue", alpha = 0.7, outlier.color = "red", outlier.shape = 16) +
  labs(x = "Credit Policy", y = "FICO Score") +
  ggtitle("Boxplot of FICO Score by Credit Policy") +
  theme_minimal() +
  theme(axis.text = element_text(size = 12), axis.title = element_text(size = 14),
        plot.title = element_text(size = 16, hjust = 0.5))

#Plot 4
# Scatterplot
ggplot(df, aes(x = int.rate, y = log.annual.inc, color = factor(not.fully.paid))) +
  geom_point(alpha = 0.6, size = 3) +
  labs(x = "Interest Rate", y = "Log Annual Income", color = "Not Fully Paid") +
  ggtitle("Scatterplot of Interest Rate vs. Log Annual Income") +
  theme_minimal() +
  theme(axis.text = element_text(size = 12), axis.title = element_text(size = 14),
        plot.title = element_text(size = 16, hjust = 0.5))

# Performing SVM on not.fully.paid column 
library(e1071) 
# Prepare the Data
features <- df[, -which(names(df) == "not.fully.paid")]  # Features (exclude the target variable)
target <- df$not.fully.paid  # Target variable

# Split the Data into Training and Testing Sets
set.seed(123)  # Set seed for reproducibility
indices <- sample(1:nrow(df), nrow(df)*0.7)  # Randomly select indices for training set
train_data <- df[indices, ]  # Training set
test_data <- df[-indices, ]  # Testing set

# Train the SVM Model
svm_model <- svm(not.fully.paid ~ ., data = train_data, kernel = "radial")

# Evaluate the Model
svm_predictions <- predict(svm_model, test_data[,-which(names(test_data) == "not.fully.paid")])  # Predictions
accuracy <- mean(svm_predictions == test_data$not.fully.paid)  # Accuracy
print(paste("Accuracy:", accuracy))

# Actual vs Predicted Class 
results <- data.frame(Actual = test_data$not.fully.paid, Predicted = svm_predictions)
print(results)


