library(shiny)
library(tidyverse)

ui <- fluidPage( 
    # Change yourname to your first name and last name
    h1("Programming Assignment 1: Jimin Pei"),
    selectInput(inputId = "DeathConf",label = "Death/Confirmed",
                choices = c("Deaths", "Confirmed")),
    plotOutput("plot1")
)

server <- function(input, output) { 
    # Put the code for Part a-c below
    rawdata <- read_csv("data_PA1.csv")
    data <- pivot_longer(rawdata,
                         -c(1, 2),
                         names_to = "Date", values_to = "Count")
    data$Date <- as.Date(data$Date, "%m/%d/%y")
    
    output$plot1 <- renderPlot({ 
        #Put the code for Part d below
        #data1 = data[data$Type=="Deaths",]
        data1 = data[data$Type==input$DeathConf,]
        # Put the code for Part e below
        ggplot(data = data1) +
            geom_line(mapping = aes(x =Date, y = Count, color =
                                         Region))
        
    }) 
} 
shinyApp(ui, server) 

