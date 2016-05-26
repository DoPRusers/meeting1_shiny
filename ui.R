# This is the DoP - Ruser shiny example using the allentest data
#
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Allentest data exploration"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
     # Ask user for title
     textInput("mytitle",label = "Plot title", value = "My plot"),
     # Ask user for x variable
     selectInput("xvar", label = "Select x-axis variable", 
                 choices = c("Subj","ACL","SDMT","Vocab","Abstract"),
                 selected = "SubJ"),
     # Ask user for y variable
          selectInput("yvar", label = "Select y-axis variable", 
                 choices = c("Subj","ACL","SDMT","Vocab","Abstract"),
                 selected = "ACL"),
     # Ask user if density colors should be used
     checkboxInput("densColor", label = "Plot with density colors", value = FALSE, width = NULL)
    ),

    # Show a plot of the allentest data
    mainPanel(
      plotOutput("myPlot")
    )
  )
))
