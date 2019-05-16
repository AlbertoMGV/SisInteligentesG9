#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Proyecto 4: Arboles de Decision"),
   
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
       sliderInput(inputId = "minsplit",
                   label = "Minsplit:",
                   min = 1,
                   max = 1000,
                   value = 30),
       
       sliderInput(inputId = "maxdepth",
                   label = "Maxdepth:",
                   min = 1,
                   max = 30,
                   value = 30),
       
       sliderInput(inputId = "cp",
                   label = "CP:",
                   min = 0,
                   max = 1,
                   value = 0.5)
       
     ),
     
     
     mainPanel(
       tabsetPanel(id = "tabs",
                   tabPanel("Contenido",tableOutput("contents")),
                   tabPanel("% Aciertos",plotOutput("target")),
                   tabPanel("Arbol",plotOutput("arbol"))
       )
       
     )
   )
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  library(rpart)
  library(rpart.plot)
  library(C50)
  library(caret)
  
  output$target <- renderPlot({
    
    #Cargamos data
    
    data <- read.csv(file = input$file1$datapath)
    folds <- createMultiFolds(y = data$Churn, k = 10, times = 5)
    tasaAciertoIndividual = 0
    tasaAciertoITotal = 0
    porcenAciertos = c()
    
    for(i in 1:5){
      tasaAciertoIndividual = 0
      #Creamos sets de datos
      train.data  <- data[folds[[i]], ]
      test.data <- data[-folds[[i]], ]
      #Arbol de decis por cada uno
      parametros <- rpart.control(minsplit = input$minsplit,
                                  maxdepth = input$maxdepth,
                                  cp = input$cp)
      model <- rpart(formula=Churn~., data=train.data, method = "class", control = parametros)
      #Predicciones
      prediction <- predict(model, test.data, type="class")
      #acciertos
      tasaAciertoIndividual = sum(prediction == test.data$Churn) / nrow(test.data)
      tasaAciertoITotal = tasaAciertoITotal + tasaAciertoIndividual
      porcenAciertos = c(porcenAciertos,tasaAciertoIndividual)
      
    }
    
    barplot(porcenAciertos,main="Tasa de aciertos por ejecucion", xlab=paste("Media de la tasa de aciertos (linea roja): ", toString(round(tasaAciertoITotal/5,5)),"%"), col=c("lightblue"), ylim=c(0,1),names.arg=c(paste(round(porcenAciertos[1],5),"%"),paste(round(porcenAciertos[2],5),"%"), paste(round(porcenAciertos[3],5),"%"), paste(round(porcenAciertos[4],5),"%"), paste(round(porcenAciertos[5],5),"%")))
    abline(h=tasaAciertoITotal/5, col="red")
    
  })
  output$arbol <- renderPlot({
    
    #Cargamos data
    
    data <- read.csv(file = input$file1$datapath)
    folds <- createMultiFolds(y = data$Churn, k = 10, times = 5)
    tasaAciertoIndividual = 0
    tasaAciertoITotal = 0
    porcenAciertos = c()
    
    for(i in 1:5){
      tasaAciertoIndividual = 0
      #Creamos sets de datos
      train.data  <- data[folds[[i]], ]
      test.data <- data[-folds[[i]], ]
      #Arbol de decis por cada uno
      parametros <- rpart.control(minsplit = input$minsplit,
                               maxdepth = input$maxdepth,
                               cp = input$cp)
      model <- rpart(formula=Churn~., data=train.data, method = "class", control = parametros)
      #Predicciones
      prediction <- predict(model, test.data, type="class")
      #acciertos
      tasaAciertoIndividual = sum(prediction == test.data$Churn) / nrow(test.data)
      tasaAciertoITotal = tasaAciertoITotal + tasaAciertoIndividual
      porcenAciertos = c(porcenAciertos,tasaAciertoIndividual)
      
    }
    
    rpart.plot(x=model, main="Representacion del Arbol de decision")
    
    
  })
  output$contents <- renderTable({
    
    req(input$file1)
    tryCatch(
      {
        #Leemos el archivo
        dat <- read.csv(file = input$file1$datapath)
        #Eliminamos la columna Phone
        dat$Phone <- NULL
      },
      error = function(e) {
        # return a safeError if a parsing error occurs
        stop(safeError(e))
      }
    )
    return(dat)
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

