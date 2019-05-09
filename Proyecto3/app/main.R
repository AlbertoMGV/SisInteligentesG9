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
training.samples <- data$target %>% createDataPartition(p = 0.8, list = FALSE)

train.data  <- data[training.samples, ]
test.data <- data[-training.samples, ]
# CREO MODELO LINEAL
linear.model <- lm(target ~., data = train.data)
#PREDICCIONES
predictions <- linear.model %>% predict(test.data)
#ERROR
abs(predictions - test.data$target)

data.frame( R2 = R2(predictions, test.data$target),
            RMSE = RMSE(predictions, test.data$target),
            MAE = MAE(predictions, test.data$target))

print(data)
