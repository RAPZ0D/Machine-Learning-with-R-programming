# Machine-Learning-with-R-programming
This Repository includes all the Machine Learning (ML) topics covered in R programming language 

[IDE (Integrated Development Environment)](#IDE-Integrated-Development-Environment)

[How to install R packages](#How-to-Install-Packages-in-R)

[Useful Libraries to intstall in R for Machine Learning](#Useful-Libraries-in-R-for-Machine-Learning)

[Linear Regression Project](#Linear-Regression-Project)

[Logistic Regression Project](#Logistic-Regression-Project)

[KNN](#KNN)

[Decision Trees & Random Forest](#decision-trees--random-forest)

[Support Vector Machines](#Support-Vector-Machines)


## About Me
Hey there! 👋 I'm Joel Mendonsa, a passionate student diving deep into the exciting world of data science. Currently pursuing my studies in data science, I've recently completed a course in artificial intelligence, delving into the realms of machine learning algorithms and techniques. This semester, I'm thrilled to explore the mathematical foundations behind machine learning, all while sharpening my skills in the R programming language.

## Introduction
Welcome to my repository on Machine Learning with R! As part of my journey in data science education, I've embarked on this project to consolidate my learnings and share valuable resources with fellow learners like you. Whether you're a beginner stepping into the realm of machine learning or an enthusiast seeking to deepen your understanding, this repository aims to provide a comprehensive guide to leveraging R for your machine learning endeavors.

# Easy Machine Learning with R

## Description
Welcome to my Machine Learning with R repository! I'm Joel Mendonsa, and here you'll find simple guides and examples to learn machine learning using R.
You'll explore basic machine learning techniques like linear regression, logistic regression, K-nearest neighbors (KNN), decision trees, random forest, support vector machines (SVM), K-means clustering, natural language processing (NLP), and neural networks.

## IDE (Integrated Development Environment)

For this project, I primarily use RStudio as my preferred IDE for R programming. Here are some of the reasons why I find RStudio to be an excellent choice:

- **User-Friendly Interface**: RStudio provides an intuitive and user-friendly interface, making it easy for both beginners and experienced R users to navigate and work with.

- **Built-In Tools**: It comes with a variety of built-in tools for code editing, debugging, package management, version control, and more, streamlining the development workflow.

- **Interactive Environment**: RStudio offers an interactive environment with features like code execution, variable exploration, and visualization integration, enhancing productivity and collaboration.

- **R Markdown Support**: RStudio has excellent support for R Markdown, allowing seamless integration of code, output, and narrative text for reproducible research and dynamic reporting.

While RStudio is my primary choice, I've also experimented with Visual Studio Code (VS Code) for R development. VS Code is another powerful IDE with a wide range of features and extensions. However, personally, I find RStudio to be better suited for R programming due to its specialized features and seamless integration with R.

Before installing RStudio, ensure you have R installed on your desktop. If you haven't installed R yet, you can download it here this link will take you to the official website of R [R Program](https://cran.r-project.org/). Once you have R installed, click on this link to download and install RStudio Desktop [R Studio](https://posit.co/download/rstudio-desktop/).


## Useful Libraries in R for Machine Learning
When it comes to machine learning in R, several libraries stand out for their ease of use and powerful functionality. Some of the most popular ones include:

- **caret**: A versatile package for classification and regression training.
- **randomForest**: Implements random forest algorithms for classification and regression.
- **e1071**: Provides functions for support vector machines, clustering, and more.
- **nnet**: Used for training and testing neural networks.
- **tm**: A text mining package often used for natural language processing tasks.
- **cluster**: Offers various clustering algorithms.
- **glmnet**: Implements Lasso and Elastic-Net regularized generalized linear models.
- **ggplot2**: A powerful package for data visualization, allowing you to create elegant and informative plots.

These libraries, among others, provide a wide range of tools to tackle different machine learning tasks in R, making them essential resources for any data scientist, and remember there is a vast library in R and I would suggest you to look into it and make use of each library you need.

## How to Install Packages in R 
Installing packages in R is straightforward and can be done using the `install.packages()` function. Here's a simple guide:

1. **Open R Console**: Launch R and open the R console.

2. **Install Package**: To install a package, use the following syntax:
   ```R
   install.packages("package_name")

3. **Example**: For instance, to install the caret package, you can use the following command:

   ```R
   install.packages("caret")
   ```
# Linear Regression Project

## Overview
Welcome to the Linear Regression project folder! In this repository, you'll find practice and project files related to linear regression analysis. Linear regression is a fundamental statistical technique used to model the relationship between one or more independent variables and a dependent variable.

### What is Linear Regression?
Linear regression is a statistical method used to model the relationship between a dependent variable and one or more independent variables by fitting a linear equation to observed data. Simple linear regression, a specific form of linear regression, involves a single independent variable used to predict the value of a dependent variable. It models the relationship between two variables by fitting a linear equation to the observed data points. The equation takes the form:

\[ y = mx + c \]

Where:
- \( y \) is the dependent variable (the variable we want to predict).
- \( x \) is the independent variable (the variable we use to make predictions).
- \( m \) is the slope of the line (representing the relationship between \( x \) and \( y \)).
- \( c \) is the y-intercept (the value of \( y \) when \( x \) is 0).

Simple linear regression aims to find the best-fitting line through the data points, minimizing the sum of squared differences between the observed and predicted values of the dependent variable.

#### Folders in this project 
- **linear_regression.r**: This folder contains a practice R notebook for linear regression analysis.

- **Linearreg_project.r**: This folder contains a real-world project R notebook involving linear regression analysis.

#### LINK to understand the math formula 

[Linear Regression Math formula](https://www.statisticshowto.com/probability-and-statistics/regression-analysis/find-a-linear-regression-equation/)

#### Sample Screenshot 
I have included screenshots for viewers to view my output and graphs 
![plot 6](https://github.com/RAPZ0D/Machine-Learning-with-R-programming/assets/100001521/cdb8e3dc-bfe8-464c-aa8a-8c88173f1805)

# Logistic Regression Project

### What is Logistic Regression?
Logistic regression is a statistical method used for classification tasks, particularly when the outcome variable is binary (i.e., has only two possible outcomes). Unlike linear regression, which predicts continuous values, logistic regression predicts the probability that an observation belongs to a particular category.

#### Logistic Function (Sigmoid Function)
The logistic function, also known as the sigmoid function, is used in logistic regression to model the probability of the positive class. 

#### MATH FORMULA EXPLAINED 
[Logistic Regression Math](https://www.spiceworks.com/tech/artificial-intelligence/articles/what-is-logistic-regression/)

### Sample Project Screenshot
![plot 2](https://github.com/RAPZ0D/Machine-Learning-with-R-programming/assets/100001521/6c65e8ed-5d3b-474e-ae31-80136ba40e98)


# KNN

### 1. What is KNN (K-Nearest Neighbors)?

KNN, or K-Nearest Neighbors, is a simple and intuitive machine learning algorithm used for classification and regression tasks. It is based on the principle of similarity, where an object is classified by a majority vote of its neighbors, with the object being assigned to the class most common among its k nearest neighbors.

#### How Does it Work?

1. **Choose K**: Determine the number of neighbors (K) to consider. This can be any positive integer.

2. **Calculate Distance**: Measure the distance between the query instance and all the training samples.

3. **Find Nearest Neighbors**: Select the K samples in the training data that are closest to the query instance.

4. **Majority Vote**: Assign the class label by majority vote among the K nearest neighbors.

### Applications of KNN:

- **Classification**: KNN can be used for classification tasks such as image recognition, handwriting recognition, and sentiment analysis.

- **Regression**: In regression tasks, KNN can predict continuous values based on the average of the values of its nearest neighbors.

- **Anomaly Detection**: KNN can be employed to identify anomalies or outliers in data.

- **Recommendation Systems**: KNN can be used in recommendation systems to recommend items or products to users based on similarity measures.

### 2. Mathematical Formula:

 KNN MATH FORMULA EXPLAINED 
[MATH IN KNN](https://towardsdatascience.com/the-math-behind-knn-3d34050efb71)

### SAMPLE SCREENSHOT FROM THE PROJECT 
![new plot 2](https://github.com/RAPZ0D/Machine-Learning-with-R-programming/assets/100001521/1f0224da-18cb-49ea-aafe-e11096093324)

# Decision Trees & Random Forest

## Decision Trees 

### What is a Decision Tree?

A Decision Tree is a tree-like model used for classification and regression tasks in machine learning. It works by partitioning the input space into regions and assigning a label or value to each region.

### How Does it Work?

1. **Splitting**: The tree is built by recursively splitting the data into subsets based on the values of input features. Each split is chosen to maximize the homogeneity (purity) of the resulting subsets with respect to the target variable.

2. **Decision Nodes**: Each internal node of the tree represents a decision based on the value of a particular feature.

3. **Leaf Nodes**: The terminal nodes of the tree, called leaf nodes, assign a label or value to the corresponding subset of data.

### Applications of Decision Trees:

- **Classification**: Decision Trees are commonly used for classification tasks such as spam detection, medical diagnosis, and customer segmentation.

- **Regression**: In regression tasks, Decision Trees can predict continuous values, making them useful for predicting house prices, stock prices, etc.

## Random Forest

### What is Random Forest?

Random Forest is an ensemble learning technique that combines multiple Decision Trees to improve predictive performance and reduce overfitting.

### How Does it Work?

1. **Bootstrapping**: Random Forest builds multiple Decision Trees using bootstrapped samples of the training data (sampling with replacement).

2. **Feature Randomness**: At each split of a Decision Tree, only a random subset of features is considered, reducing the correlation between trees and improving diversity.

3. **Voting**: For classification tasks, the final prediction is made by aggregating the predictions of all trees (majority voting). For regression tasks, the final prediction is the average of predictions from individual trees.

### Applications of Random Forest:

- **Classification and Regression**: Random Forest is widely used for both classification and regression tasks across various domains due to its robustness and high accuracy.

- **Anomaly Detection**: Random Forest can be used for anomaly detection in fraud detection systems, network security, etc.

- **Feature Importance**: Random Forest can also be used to assess the importance of different features in predicting the target variable.

#### Math Behind Decision Tree Algorithm explained
[Decision Tree Math](https://ankitnitjsr13.medium.com/math-behind-decision-tree-algorithm-2aa398561d6d)

### Sample Project Screenshot

![new plot 4](https://github.com/RAPZ0D/Machine-Learning-with-R-programming/assets/100001521/14794ee0-3091-4962-8417-e49b0e833af0)


## Support Vector Machines 
### What is Support Vector Machines?

Support Vector Machines (SVM) is a powerful supervised machine learning algorithm used for classification and regression tasks. It works by finding the optimal hyperplane that best separates data points into different classes or groups.

### How Does it Work?

1. **Maximizing Margin**: SVM aims to find the hyperplane that maximizes the margin, i.e., the distance between the hyperplane and the nearest data points of each class. This allows SVM to achieve good generalization performance.

2. **Kernel Trick**: SVM can handle nonlinear data by mapping the original input space into a higher-dimensional feature space using a kernel function. This allows SVM to find a linear decision boundary in the transformed space.
