# Linear Regression (this dataset has grades and info related to students)
library(ggplot2)
library(ggthemes)
library(dplyr)
library(corrgram)
library(corrplot)
df <- read.csv("student.csv",sep=';')
head(df)

summary(df)

#Checking for null values
any(is.na(df)) # there are no null values present

#Structure of dataframe
str(df)

#numeric columns
num_cols <- sapply(df,is.numeric)
head(num_cols)

#correlation 
cor_data <- cor(df[,num_cols])
print(cor_data)

# Heatmap of correlation 
library(viridis)
print(corrplot(cor_data,method='color',col=viridis(100)))

#Correlation using corrgram
corrgram(df)

corrgram(df,order = TRUE, lower.panel = panel.shade,
         upper.panel = panel.pie,
         text.panel = panel.txt)
# Enhanced corrplotplot
corrplot(cor_data, method = "ellipse", type = "upper", 
         col = colorRampPalette(c("red", "white", "blue"))(100), 
         tl.col = "black", tl.srt = 45, diag = FALSE)

#setting a seed and splitting up the sample 
library(caTools)
set.seed(101)
sample <- sample.split(df$G3,SplitRatio = 0.7)

train <- subset(df,sample == TRUE)
test <- subset(df,sample == FALSE)
print(train)
print(test)

# Building the model 
model <- lm(G3 ~.,data = train)

print(model)
print(summary(model))

# Visuals on the model
plot(model)

# Predictions 
g3_predictions <- predict(model,test)
results <- cbind(g3_predictions, test$G3)
colnames(results) <- c('predicted','acutal')
results <- as.data.frame(results)
print(head(results))

