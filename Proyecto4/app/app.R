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
                   tabPanel("Content",tableOutput("contents")),
                   tabPanel("Target",plotOutput("target"))
                   
       )
       
     )
   )
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  
  library(RKEEL)
  library(caret)
  library(ggplot2)
  library(lattice)
  library(plotly)
  
  output$target <- renderPlot({
    
    #TODO: Use this var for selecting Target
    type = input$combobox
    
    err=0
    errs=c()
    data <- read.csv(file = input$file1$datapath)
    #Eliminamos la columna Phone
    data$Phone = NULL
    data$Salary=as.numeric(data$Salary)
    folds <- createMultiFolds(y = data$Salary, k = 10, times = 5)
    
    for(i in 1:5){
      train.data  <- data[folds[[i]], ]
      test.data <- data[-folds[[i]], ]
      linear.model <- lm(Salary ~., train.data)
      prediction <- predict(linear.model, test.data)
      MAE = MAE(prediction, test.data$Salary)
      errs = c(errs, MAE)
      #plot(prediction)
      #plot(linear.model,which=c(1:6))
      #plot(linear.model)
      #plot(prediction, test.data)
    }
    for (er in errs) {
      print(er)
      err=err+er
    }
    
    
    barplot(errs,main="Error in each Fold",
            xlab=paste("Error medio (linea roja): ", toString(round(err/5,2))), col=c("lightblue"), ylim=c(0,32),names.arg=c("Fold 1", "Fold 2", "Fold 3", "Fold 4", "Fold 5"))
    abline(h=err/5, col="red")
    
    
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
    
    if(input$disp == "head") {
      return(head(dat))
    }
    else {
      return(dat)
    }
    
    
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

