#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

rm(list=ls())
cat("\014")
graphics.off()
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()
dir()


library(shiny)
library(RKEEL)
# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Upload a File & Select attribute"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      # Input: Select a file ----
      fileInput("file1", "1. Choose a File",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv",".dat")),

      # Horizontal line ----
      tags$hr(),

      # Input: Checkbox if file has header ----
      checkboxInput("header", "Header", TRUE),

      # Input: Select separator ----
      radioButtons("sep", "2. Separator",
                   choices = c(Comma = ",",
                               Semicolon = ";",
                               Tab = "\t"),
                   selected = ","),

      # Input: Select quotes ----
      radioButtons("quote", "3. Quote",
                   choices = c(None = "",
                               "Double Quote" = '"',
                               "Single Quote" = "'"),
                   selected = '"'),
      # Horizontal line ----
      tags$hr(),

      # Input: Select number of rows to display ----
      radioButtons("disp", "4. Display",
                   choices = c(Head = "head",
                               All = "all"),
                   selected = "head"),
      selectInput("combobox","5. Select an attribute to predict",choices = c("Batting_average" = 1,"On.base_percentage"=2,
                                                                             "Runs"=3,"Hits"=4,"Doubles"=5,"Triples"=6,"HomeRuns"=7,"Runs_batted_in"=8,"Walks"=9,"Strike.Outs"=10,
                                                                             "Stolen_bases"=11,"Errors"=12,"Free_agency_eligibility"=13,"Free_agent"=14,"Arbitration_eligibility"=15,"Arbitration"=16,
                                                                             "Salary"=17))


    ),


    mainPanel(
      tabsetPanel(id = "tabs",
                  tabPanel("Content",tableOutput("contents")),
                  tabPanel("Target",plotOutput("target"))

      )

    )
  )

)

