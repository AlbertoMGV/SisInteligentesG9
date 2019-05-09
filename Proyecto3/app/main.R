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
training.samples <- createMultiFolds(y=data$Salary,k = 10, times = 5)



train.data  <- data[training.samples[[i]], ]
test.data <- data[-training.samples[[i]], ]
# CREO MODELO LINEAL
linear.model <- lm(target ~., train.data)
#PREDICCIONES
predictions <- linear.model %>% predict(test.data)
#ERROR
abs(predictions - test.data$target)

data.frame( R2 = R2(predictions, test.data$target),
            RMSE = RMSE(predictions, test.data$target),
            MAE = MAE(predictions, test.data$target))

# Define training control
train.control <- trainControl(method = "cv", number = 5)
# Train the model
model <- train(Fertility ~., data, method = "lm",
               trControl = train.control)
# Summarize the results

#???print(model)

print(data)
