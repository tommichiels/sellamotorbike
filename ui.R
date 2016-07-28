#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Set your price to sell your motorbike"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       p("First input your kilometer and year when your bike was build. With the price slider you can then set your price. The size of de marker is your price. So to set a competive price set the size smaller then your closest neightbours"),
       sliderInput("kilometerstand",
                   "How much kilometers did you ride:",
                   min = 1,
                   max = 60000,
                   value = 10000),
       dateInput('date',
                 label = 'When was your motorbike build: yyyy-mm-dd',
                 value = Sys.Date()
       ),
       sliderInput("prijs",
                   "How much do you want to sell your bike:",
                   min = 500,
                   max = 15000,
                   value = 5000)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("trendPlot")
       #plotOutput("distPlot")
    )
  )
))
