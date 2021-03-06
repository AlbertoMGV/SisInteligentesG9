# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

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
    data = read.keel(input$file1$datapath)
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
        dat <- read.keel(input$file1$datapath)
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
