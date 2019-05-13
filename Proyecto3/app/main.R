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
data$Salary=as.numeric(data$Salary)

# Split the data into training and test set

folds <- createMultiFolds(y = data$Salary, k = 10, times = 5)

for(i in 1:5){

  #Segement your data by fold using the which() function
  train.data  <- data[folds[[i]], ]
  test.data <- data[-folds[[i]], ]

  #Use the test and train data partitions however you desire...

  linear.model <- lm(Salary ~., train.data)
  prediction <- predict(linear.model, test.data)

  accuracy <-  data.frame( R2 = R2(prediction, test.data$Salary, form = "traditional"),
                           RMSE = RMSE(prediction, test.data$Salary),
                           MAE = MAE(prediction, test.data$Salary))

  print(accuracy)


}

# Define training control
#train.control <- trainControl(method = "cv", number = 5, savePredictions = "all")
# Train the model
#model <- train(Salary ~., data = data$Salary, method = "lm",
#trControl = train.control)

#summary(model)

#model$result

#print(prediction - test.data)
