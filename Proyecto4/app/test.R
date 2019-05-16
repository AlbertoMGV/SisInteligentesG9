# =======================================================================
# Names: Alberto Miranda & Danel Lorente
# Group Number: 
# Assignment: Sistemas Inteligentes
# Date: 27/03/2019
# =======================================================================

rm(list=ls())
cat("\014")
graphics.off()
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()
dir()

# Cargamos librerias

library(rpart)
library(rpart.plot)
library(C50)
library(caret)

#Cargamos data

data <- read.csv(file = "../data/churn.csv")
folds <- createMultiFolds(y = data$Churn, k = 10, times = 5)
tasaAciertoIndi = 0
tasaAciertoITot = 0

for(i in 1:5){
  tasaAciertoIndi = 0
  #Creamos sets de datos
  train.data  <- data[folds[[i]], ]
  test.data <- data[-folds[[i]], ]
  #Arbol de decis por cada uno
  #TODO: Aqui tenemos que meter el min max y CP!!!
  model <- rpart(formula=Churn~., data=train.data)
  #Predicciones
  prediction <- predict(model, test.data, type="class")
  #acciertos
  tasaAciertoIndi = sum(prediction == test.data$Churn) / nrow(test.data)
  tasaAciertoITot = tasaAciertoITot + tasaAciertoIndi
  print(paste("Tasa acierto ejecucion Nº",i,": ",tasaAciertoIndi))
  #Representacion Visual
  rpart.plot(x=model)
}
print(paste("Tasa de acierto medio: ", tasaAciertoITot/5))
