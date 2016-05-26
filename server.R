
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
mydata <- read.table("data/allentest.txt", header = T)

shinyServer(function(input, output) {

  output$myPlot <- renderPlot({
    
    # Switch to control data for the X-axis
    x <- switch (input$xvar,
                    "Subj" = mydata$Subj,
                    "ACL" = mydata$ACL,
                    "SDMT" = mydata$SDMT,
                    "Vocab" = mydata$Vocab,
                    "Abstract" = mydata$Abstract)
    
    # Switch to control data for the Y-axis
    y <- switch (input$yvar,
                 "Subj" = mydata$Subj,
                 "ACL" = mydata$ACL,
                 "SDMT" = mydata$SDMT,
                 "Vocab" = mydata$Vocab,
                 "Abstract" = mydata$Abstract)
    
    # If box is selected calculate density colors else plot in green
    if(input$densColor){
      mycolor <- densCols(x, y)
    }else{
      mycolor <- "green"
    }

    # Run correlation model
    mymodel <- lm(y~x)
    mysummary <- summary(mymodel) # Calculate model summary statistics
    myr <- round(mysummary$r.squared,2) # Pull out r-squared value
    myp <- round(mysummary$coefficients[,4][2],5) # Pull out model P-value
    
    # Plot allantest data
    plot(x, y, main = input$mytitle, xlab = input$xvar, ylab= input$yvar, pch = 19, col = mycolor)
    # Add regression line
    abline(mymodel, col = "red")
    # Add legend
    legend("top", bty = "n", legend = paste("R-squared",myr," - P-value", myp))

  })

})
