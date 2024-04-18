# Natural Language Processing 

df <- read.csv('text.csv')
head(df)

str(df)

any_null <- any(is.na(df))
null_in_each_column <- colSums(is.na(df))
print(null_in_each_column) # There are no null values in the dataset 

summary(df)

head(df, n=1)

# Text Processing 
library(tm)
processed_text <- tolower(df$text)
processed_text <- removePunctuation(processed_text)
processed_text <- removeNumbers(processed_text)
processed_text <- removeWords(processed_text, stopwords("en"))
print(processed_text) # processed text output

# Tokenization 
library(tokenizers)
tokens <- unlist(tokenize_words(df$text))
print(tokens)


# STEMMING 
library(SnowballC)
stemmed_text <- wordStem(df$text)
print(stemmed_text)

#Sentiment analysis 
library(sentimentr)
df_subset <- df[1:10, , drop = FALSE]
sentiment_scores <- sentiment(df_subset$text)
print(sentiment_scores) # Since the dataset is too large i only used 10 rows 
