# Logistic Regression 
# Reading the test and the train dataset
train <- read.csv("titanic_train.csv")
test <- read.csv("titanic_test.csv")
head(train)
head(test)

#Checking for null values
print("The null values for the train dataset are:")
print(colSums(is.na(train))) # Age has 177 null values 
print("The null values for test dataset are:")
print(colSums(is.na(test))) # Age has 86 and fare has 1 null values 

#Survivial Plot 
library(ggplot2)
ggplot(train, aes(x = factor(Survived), fill = factor(Survived))) +
  geom_bar(color = "red", size = 0.5) +  # Add borders to the bars with black color
  scale_fill_manual(values = c("0" = "lightblue", "1" = "gold")) +
  labs(x = "Survived", y = "Count") +
  scale_x_discrete(labels = c("Not Survived", "Survived")) +
  geom_text(stat = "count", aes(label = ..count..), position = position_stack(vjust = 0.5)) +
  theme_bw()

#Pclass Plot 
ggplot(train, aes(x = factor(Pclass), fill = factor(Pclass))) +
  geom_bar() +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, color = "red", size = 3) +  # Add count labels on the bars
  facet_wrap(~ factor(Survived)) +  # Separate bars by the Survived variable
  scale_fill_manual(values = c("1" = "#4BB3B7", "2" = "#DBCDA7", "3" = "#40474D")) +  # Specify custom colors for Pclass
  labs(x = "Pclass", y = "Count") +
  theme_bw()

# SEX regarding only of those who survided  
survived_data <- subset(train, Survived == 1)
ggplot(survived_data, aes(x = Sex, fill = Sex)) +
  geom_bar(color = "black", size = 0.3) +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, color = "black", size = 3) +  # Add count labels on the bars
  scale_fill_manual(values = c("female" = "#FF6EB4", "male" = "#4286f4")) +  # Specify custom colors for Sex
  labs(x = "Sex", y = "Count") +
  theme_bw()

# SEX of those who did not survived
not_survived_data <- subset(train, Survived == 0)
ggplot(not_survived_data, aes(x = Sex, fill = Sex)) +
  geom_bar(color = "black", size = 0.3, alpha = 0.5) +  # Add borders to the bars with black color and size 1, and set alpha value
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, color = "black", size = 3) +  # Add count labels on the bars
  scale_fill_manual(values = c("female" = "#FF8C94", "male" = "#76ADDB")) +  # Specify custom colors for Sex
  labs(x = "Sex", y = "Count") +
  theme_bw()

#Histogram on age 
ggplot(train, aes(x = Age, fill = Sex)) +
  geom_histogram(color = "black", binwidth = 5, alpha = 0.8) +  # Add border, specify binwidth and alpha value
  scale_fill_manual(values = c("female" = "#f9d53e", "male" = "#96eae3")) +  # Specify custom colors for Sex
  labs(x = "Age", y = "Frequency") +
  theme_bw()

# Boxplot of Pclass and age 
pl <- ggplot(train, aes(x = factor(Pclass), y = Age)) +
  geom_boxplot(aes(group = factor(Pclass), fill = factor(Pclass)), alpha = 0.4) +
  scale_y_continuous(breaks = seq(min(0), max(80), by = 2)) +
  theme_bw()

pl

# Building a logistic regression model 
#Replacing the null values with the mean values
train$Age[is.na(train$Age)] <- mean(train$Age, na.rm = TRUE)
test$Age[is.na(test$Age)] <- mean(test$Age, na.rm = TRUE)
test$Fare[is.na(test$Fare)] <- mean(test$Fare, na.rm = TRUE)
print(colSums(is.na(train)))
print(colSums(is.na(test)))

str(train)

#Removing the columns that are not needed
library(dplyr)
train <- select(train, -PassengerId, -Name, -Ticket, -Cabin)
test <- select(test, -PassengerId, -Name, -Ticket, -Cabin)

# Convert specific columns to factors in train dataset
train$Survived <- factor(train$Survived)
train$Pclass <- factor(train$Pclass)
train$Parch <- factor(train$Parch)
train$SibSp <- factor(train$SibSp)

# Convert specific columns to factors in test dataset
test$Pclass <- factor(test$Pclass)
test$Parch <- factor(test$Parch)
test$SibSp <- factor(test$SibSp)

#Training the Model 
log_model <- glm(formula = Survived ~ . , family = binomial(link = 'logit'), data = train)
summary(log_model)

# Predicting the model 
library(caTools)
set.seed(101)
split <- sample.split(train$Survived, SplitRatio = 0.70)

final_train <- subset(train, split == TRUE)
final_test <- subset(train, split == FALSE)

final_log_model <- glm(formula = Survived ~ . , family = binomial(link = 'logit'), data = final_train)

summary(final_log_model)

# Predicting the accuracy 
fitted_probabilities <- predict(final_log_model, newdata = final_test, type = 'response')
# Convert probabilities to binary predictions (1 or 0) based on a threshold of 0.5
fitted_results <- ifelse(fitted_probabilities > 0.5, 1, 0)
misclassification_error <- mean(fitted_results != final_test$Survived)
accuracy <- 1 - misclassification_error

print(paste('Accuracy:', accuracy))

#Confusion matrix
conf_matrix <- table(final_test$Survived, fitted_probabilities > 0.5)
# Print confusion matrix
print(conf_matrix)