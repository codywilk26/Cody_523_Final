library(shiny)
library(tidyverse)
library(plotly)
library(jpeg)

KO_2017 <- read.csv("Final_Data/2017_KO.csv")
Punt_2018 <- read.csv("Final_Data/2018_P.csv")
KO_2018 <- read.csv("Final_Data/2018_KO.csv")
Punt_2019 <- read.csv("Final_Data/2019_P.csv")
KO_2019 <- read.csv("Final_Data/2019_KO.csv")
Punt_total <- read.csv("Final_Data/Punts.csv")
KO_total <- read.csv("Final_Data/Kickoffs.csv")
Career <- read.csv("Final_Data/Summary.csv")

ui <- fixedPage(
  titlePanel("Cody Wilkinson's Kicking Archives"),
  
  # Main panel with the image and plot
  mainPanel(
    fluidRow(
    column(6, img(src = "Cody.jpg", width = 350, height = 275)),
    column(6, img(src = "Champion.jpg", width = 460, height = 275))
  ),

    # Sidebar layout with a sidebar panel for the selectInput
    sidebarLayout(
      sidebarPanel(
        selectInput(inputId = "y_var",
                    label = "Stat",
                    choices = c("KO_Yards", 
                                "KO_Number", 
                                "KO_Avg",
                                "Touchback",
                                "OB",
                                "Punt_Yards", 
                                "Punt_Number",
                                "Punt_Avg"),
                    selected = "KO_Yards"
        )
      ),
      
      # Output for the plot
      mainPanel(
        plotOutput("Plottington", width = "100%")
      )
    )
  )
)
    # Define server with a function that fixes the x axis at the Year variable
    # and allows the y variable to selected by the selectInput() in the UI

server <- function(input, output) {
  output$Plottington <- renderPlot({
    ggplot(Career, aes(x = Year, y = get(input$y_var), fill = factor(Year))) +
      geom_col() +
      geom_text(aes(label = get(input$y_var)), vjust = -0.5) +
      scale_fill_manual(values = c("2017" = "#BEB3F7",
                                   "2018" = "#C07FD7",
                                   "2019" = "#9F5FAA")) +
      theme_linedraw() +
      theme_classic()+
      theme(legend.position = "none") +
      labs(y = input$y_var)
  })
}

shinyApp(ui = ui, server = server)