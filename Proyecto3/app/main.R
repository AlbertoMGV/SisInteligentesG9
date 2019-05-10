# =======================================================================
# Names: Alberto Miranda & Danel Lorente
# Group Number: 
# Assignment: Sistemas Inteligentes
# Date: 23/04/2019
# =======================================================================

rm(list=ls())
cat("\014")
graphics.off()
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()
dir()

# LIBRARIES (add any needed library here)
library(RKEEL)
library(caret)
library(ggplot2)
library(lattice)

data = read.keel("../data/baseball.dat")
  
# Split the data into training and test set
folds <- createMultiFolds(y=data$Salary,k = 5, times = 1)

print(folds)

for(i in 1:5){
  #Segement your data by fold using the which() function 
  train.data  <- data[folds[[i]], ]
  test.data <- data[-folds[[i]], ]
  #Use the test and train data partitions however you desire...
  
  linear.model <- lm(Salary~., train.data)
  prediction <- predict(linear.model, test.data)
  abs(prediction - test.data$Salary)
  
  data.frame( R2 = R2(prediction, test.data$Salary),
              RMSE = RMSE(prediction, test.data$Salary),
              MAE = MAE(prediction, test.data$Salary))
  
  # Define training control
  train.control <- trainControl(method = "cv", number = 5)
  # Train the model
  model <- train(Salary~., data, method = "lm",
                 trControl = train.control)

  print(model)
  
}

