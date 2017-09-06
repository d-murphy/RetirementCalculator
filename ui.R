library(shiny)
library(shinythemes)
shinyUI(fluidPage(theme = shinytheme("flatly"),
  
  # Application title
  titlePanel("When should I sell my Bitcoin?"),
  p("A retirement calculator by Dan Murphy"),
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      fluidRow(
        column(7,
               sliderInput("InitInvAge", label = h5("Current Age"), min = 18, 
                           max = 100, value = c(18), animate = TRUE)),
        column(5,
               numericInput("InInv", label = h5("Current Investments"), value = 0)               
               )
      ),
      
      fluidRow(
        column(7,
                sliderInput("YearInv", label = h5("Years to Invest"), min = 18, 
                  max = 100, value = c(22, 32), animate = TRUE)),
        column(5,
               numericInput("YearlyInv", label = h5("Annual Investment"), value = 0))
        ),
      
      fluidRow(
        column(7,
               sliderInput("OneTimeInvAge", label = h5("One-time Investment Age"), min = 18, 
                           max = 100, value = c(18), animate = TRUE)),
        column(5,
               numericInput("OneTimeInv", label = h5("One-time Investment"), value = 0))
      ),
      
      numericInput("IntRate", label = h5("Investment Return (%)"), value = 7),
      
      fluidRow(
        column(7,
               sliderInput("WdAge", label = h5("Withdrawel Age"), min = 18, 
                           max = 100, value = c(50), animate = TRUE)),
        column(5,
               numericInput("WdRate", label = h5("Withdrawel Rate (%)"), value = 4))
              )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("InvTotal", height = 325), 
      plotOutput("Inv4Pct", height = 325)
    )
  )
))