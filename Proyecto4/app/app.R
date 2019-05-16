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
       
       selectInput("combobox","CP:",choices = c(0,1))
       
       
     ),
     
     
     mainPanel(
       tabsetPanel(id = "tabs",
                   tabPanel("Contenido",tableOutput("contents")),
                   tabPanel("% Aciertos",plotOutput("target"))
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
      #TODO: Aqui tenemos que meter el min max y CP!!!
      model <- rpart(formula=Churn~., data=train.data)
      #Predicciones
      prediction <- predict(model, test.data, type="class")
      #acciertos
      tasaAciertoIndividual = sum(prediction == test.data$Churn) / nrow(test.data)
      tasaAciertoITotal = tasaAciertoITotal + tasaAciertoIndividual
      porcenAciertos = c(porcenAciertos,tasaAciertoIndividual)
      
    }
    
    barplot(porcenAciertos,main="Tasa de aciertos por ejecucion", xlab=paste("Media de la tasa de aciertos (linea roja): ", toString(round(tasaAciertoITotal/5,5)),"%"), col=c("lightblue"), ylim=c(0,1),names.arg=c(paste(round(porcenAciertos[1],5),"%"),paste(round(porcenAciertos[2],5),"%"), paste(round(porcenAciertos[3],5),"%"), paste(round(porcenAciertos[4],5),"%"), paste(round(porcenAciertos[5],5),"%")))
    abline(h=tasaAciertoITotal/5, col="red")
    
    rpart.plot(x=model)
    
    
  })
  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.
    
    req(input$file1)
    
    # when reading semicolon separated files,
    # having a comma separator causes `read.csv` to error
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

