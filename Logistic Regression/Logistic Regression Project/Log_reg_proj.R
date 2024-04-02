# Logistic Regression Proj 
# Loading the dataset 
df <- read.csv("adult_sal.csv")
head(df)
# Column 1 X has reapting null values so we need to remove them
df <- df[,-1]
head(df)

str(df)

summary(df)

#Checking for null values 
if (any(is.na(data))) {
  cat("Columns containing null values:\n")
  cat(colnames(data)[colSums(is.na(data)) > 0], sep = "\n")
} else {
  cat("There are no null values in the dataset.\n")
}

#Visualizations 
#Histogram 
bright_colors <- c("#FF5733", "#FFBD33", "#B2FF33")
dark_colors <- c("#33FFC7", "#3365FF", "#B733FF")
blended_colors <- c(bright_colors, dark_colors)
hist(df$hr_per_week, main = "Distribution of Hours per Week", xlab = "Hours per Week", col = blended_colors, border = "white", ylim = c(0, 3000), breaks = 20)

#Barplot
library(ggplot2)
ggplot(df, aes(x = age, fill = income)) +
  geom_histogram(binwidth = 1, color = "black") +
  labs(title = "Distribution of Age by Income Level", x = "Age", y = "Count") +
  theme_bw()

#BOXPLOT
ggplot(df, aes(x = education, y = age, fill = education)) +
  geom_boxplot() +
  labs(title = "Distribution of Age by Education Level", x = "Education Level", y = "Age") +
  theme_bw()

#Pie chart 
library(viridis)
df_filtered <- df[df$income == "<=50K", ]

occupation_income_counts <- table(df_filtered$occupation)

occupation_income_df <- as.data.frame(occupation_income_counts)

colnames(occupation_income_df) <- c("Occupation", "Count")

occupation_income_df <- occupation_income_df[order(-occupation_income_df$Count), ]

num_colors <- nrow(occupation_income_df)
color_palette <- viridis(num_colors)

ggplot(occupation_income_df, aes(x = "", y = Count, fill = Occupation)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  scale_fill_manual(values = color_palette) +
  labs(title = "Distribution of <=50K Income Levels by Occupation", fill = "Occupation") +
  theme_bw() +
  theme(axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        legend.title = element_text(size = 10),
        legend.text = element_text(size = 8)) +
  geom_text(aes(label = paste(round(Count / sum(Count) * 100), "%")), position = position_stack(vjust = 0.5))

# Creating the model for Logistic Regression 
library(dplyr)
library(caret)
# Drop non-numerical columns
df <- subset(df, select = -c(type_employer, education, marital, occupation, relationship, race, sex, country))
head(df)
# Convert values in income column to numerical values
df$income <- ifelse(df$income == "<=50K", 0, 1)
unique(df$income)
head(data)

# Split data into train and test sets
set.seed(123) # for reproducibility
train_index <- createDataPartition(df$income, p = 0.7, list = FALSE)
train_data <- df[train_index, ]
test_data <- df[-train_index, ]

# Fit logistic regression model
logit_model <- glm(income ~ ., data = train_data, family = binomial)

# Evaluate model performance
predicted_probs <- predict(logit_model, newdata = test_data, type = "response")
predicted_labels <- ifelse(predicted_probs > 0.5, ">50K", "<=50K")
confusion_matrix <- table(predicted_labels, ifelse(test_data$income == 1, ">50K", "<=50K"))
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
precision <- confusion_matrix[">50K", ">50K"] / sum(confusion_matrix[, ">50K"])
recall <- confusion_matrix[">50K", ">50K"] / sum(confusion_matrix[">50K", ])

# Print evaluation metrics
cat("Accuracy:", accuracy, "\n")
cat("Precision:", precision, "\n")
cat("Recall:", recall, "\n")

# Get predictions from test data
# Values tending towards 0 is <=50K
head(data.frame(predicted_probs, predicted_labels)) 
# Values tending towards 1 is >50K
tail(data.frame(predicted_probs, predicted_labels))