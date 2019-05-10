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

