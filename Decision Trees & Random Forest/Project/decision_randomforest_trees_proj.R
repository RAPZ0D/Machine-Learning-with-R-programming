#Using the ISLR library 
library(ISLR)
data(College)
head(College)

library(ggplot2)
# Pairwise scatterplot
pairs(College[, -c(1, 18)])

# Boxplot of Out-of-State vs. Private
boxplot(Outstate ~ Private, data = College, 
        col = c("skyblue", "pink"), 
        main = "Out-of-State Tuition by Private/Public",
        xlab = "Private",
        ylab = "Out-of-State Tuition",
        notch = TRUE,               
        varwidth = TRUE,            
        border = "black",           
        horizontal = TRUE,          
        las = 1,                   
        outline = TRUE,            
        notchwidth = 0.5,          
        boxwex = 0.5,               
        whisklty = 2,               
        whiskcol = "black",        
        staplelty = 2,             
        staplecol = "black"        
)

#Scatterplot
ggplot(College, aes(Room.Board, Grad.Rate)) + 
  geom_point(aes(color = Private), size = 3, alpha = 0.8) +  # Set point size and transparency
  labs(title = "Scatter Plot of Room & Board vs. Graduation Rate by Private/Public",
       x = "Room & Board", y = "Graduation Rate") +          # Set axis labels
  theme_minimal() +                                          # Set minimal theme
  scale_color_manual(values = c("skyblue", "pink")) +       # Set custom colors for Private/Public
  theme(plot.title = element_text(hjust = 0.5))              # Center the plot title


#Histogram 
ggplot(College, aes(F.Undergrad)) + 
  geom_histogram(aes(fill = Private), color = 'black', bins = 50) +
  labs(title = "Histogram of F.Undergrad by Private/Public",
       x = "F.Undergrad", y = "Frequency") +          # Set axis labels
  theme_minimal() +                                   # Set minimal theme
  scale_fill_manual(values = c("#1eefdc", '#bbda15')) + # Set new colors for Private/Public
  theme(plot.title = element_text(hjust = 0.5))       # Center the plot title

# Building Decision Trees
# Load the necessary libraries
library(rpart)
library(rpart.plot)

# Create a decision tree model
tree_model <- rpart(Private ~ ., data = College)

# Visualize the decision tree
prp(tree_model, extra = 1, main = "Decision Tree for College Dataset")

# Random Forest 
# Load the necessary library
library(randomForest)

# Create a random forest model
rf_model <- randomForest(Private ~ ., data = College)

# Print the random forest model
print(rf_model)

# Visualize variable importance
varImpPlot(rf_model)
