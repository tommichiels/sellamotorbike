#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  class <- c( "factor","numeric", "numeric", "character")
  rawData <- read.csv("./data/motto.csv",colClasses = class,sep=",",na.strings="?")
  rawData$bouwjaar <- strptime(rawData$bouwjaar,"%d/%m/%Y")
  rawData$bouwjaarNumeric <-as.numeric(rawData$bouwjaar)
  rawData$size <- (rawData$prijs - min(rawData$prijs))/(max(rawData$prijs)-min(rawData$prijs))*100
  
  
  #test if plotly works in

   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    with(rawData,plot(kilometerstand, bouwjaar,col=id))
    
  })
  
  output$trendPlot <- renderPlotly({

    mysize <- (input$prijs - min(rawData$prijs))/(max(rawData$prijs)-min(rawData$prijs))*100
    # plot price to sell your motorbike.
    p <- plot_ly(rawData, x = bouwjaar , y = kilometerstand, text = prijs, type = "scatter" , name="other bikes",mode = "markers", marker= list(size=size))
    p <- add_trace(p, x= input$date, y = input$kilometerstand,text = input$prijs, name = "my motorbike", mode = "markers", marker= list(size=mysize))
    
    # style the xaxis
    layout(p, xaxis = list(title = "Year build"), yaxis = list(title = "km driven") ,showlegend = FALSE)
  })
  
})
