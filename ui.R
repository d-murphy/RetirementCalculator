




library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("When should I Sell My Bitcoin?"),
  p("A retirement calculator by Dan Murphy"),
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("InitInvAge", label = h5("Age"), min = 18, 
                  max = 100, value = c(18)),
      numericInput("InInv", label = h5("Current Investments"), value = 0), 
      sliderInput("YearInv", label = h5("Years Investing"), min = 18, 
                  max = 100, value = c(22, 32)), 
      numericInput("YearlyInv", label = h5("Annual Investment"), value = 0),
      sliderInput("OneTimeInvAge", label = h5("One-time Investment Age"), min = 18, 
                  max = 100, value = c(18)),
      numericInput("OneTimeInv", label = h5("One-time Investment"), value = 0),
      
      numericInput("IntRate", label = h5("Interest Rate (%)"), value = 7)
      
      
      
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("InvTotal"), 
      plotOutput("Inv4Pct")
    )
  )
))
