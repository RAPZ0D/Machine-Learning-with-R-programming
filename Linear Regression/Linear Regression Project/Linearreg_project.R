# Bikesharing project 
# Reading the dataset 
df <- read.csv('bikeshare.csv')
head(df)
# Predicting the count column
print(df$count)

# Scatterplot of temp vs count 
library(ggplot2)
temp_symbols <- ifelse(df$temp < 10, 15,   # Triangle for temp < 10
                       ifelse(df$temp < 20, 17,   # Square for 10 <= temp < 20
                              ifelse(df$temp < 30, 16,   # Circle for 20 <= temp < 30
                                     18)))  # Plus for temp >= 30

ggplot(df, aes(x = temp, y = count)) + 
  geom_point(aes(color = factor(temp), shape = factor(temp)), alpha = 0.2, size = 3) + 
  scale_shape_manual(values = temp_symbols) +
  theme_bw()

# Scatterplot of count vs datetime
df$datetime <- as.POSIXct(df$datetime, format = "%Y-%m-%d %H:%M:%S")
ggplot(df, aes(x = datetime, y = count, color = temp)) +
  geom_point(alpha = 0.5) +
  scale_color_gradient(low = '#c6eb38', high = '#bb3789', name = "Temperature") +
  labs(x = "Datetime", y = "Count") +
  theme_bw()

#correlation between temp and count 
correlation <- cor(df$temp, df$count)
cat("The correlation is:", correlation)

# BOXPLOT of count and season
ggplot(df, aes(factor(season), count)) +
  geom_boxplot(aes(color = factor(season))) +
  theme_bw()

# Feature engineering
df$hour <- sapply(df$datetime, function(x) format(x, "%H"))
head(df)

#Scatterplot of count vs hours for working day
filtered_df <- df[df$workingday == 1, ]
library(viridis)
ggplot(filtered_df, aes(x = hour, y = count, color = temp)) +
  geom_point() +
  scale_color_viridis_c(name = "Temperature") +  # Using the viridis color palette
  labs(x = "Hour", y = "Count") +
  theme_bw()

# Plot for non working days
non_working_df <- df[df$workingday == 0, ]
custom_color_palette <- c("darkblue", "lightblue", "#15c0a7", "#a5d31d", "gold", "orange", "#f2014c")

ggplot(non_working_df, aes(x = hour, y = count, color = temp)) +
  geom_point(alpha = 0.7, size = 2.5) +
  scale_color_gradientn(colors = custom_color_palette, name = "Temperature") +  # Use custom color palette
  labs(x = "Hour of the Day", y = "Number of Bike Rentals") +
  theme_bw() +
  theme(
    axis.text = element_text(size = 12),
    axis.title = element_text(size = 14, face = "bold"),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10)
  )

# Building our model 
temp_model <- lm(count ~ temp, data = df)
summary(temp_model)

# How many bikes rentals predicted if temp was 25 degrees
predicted_count_25 <- predict(temp_model, newdata = data.frame(temp = 25))
print(predicted_count_25)

# using sapply function to change the hours column to numeric 
print(class(df$hour)) # it is currently character
df$hour <- sapply(df$hour, as.numeric)
print(class(df$hour))

# Building a multi feature model 
multi_feature_model <- lm(count ~ -casual - registered -season -temp -humidity, data = df)
summary(multi_feature_model)