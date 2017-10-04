library(ggplot2)
library(dplyr)
library(ggthemes)
library(plotly)



library(shiny)

shinyServer(function(input, output) {
  
  df <- reactive({
    
    df <- data.frame(Age = 17:70,
                     Total = 0, 
                     TotalWAddInv = 0,
                     Addition = 0)
    
    df$Addition <- ifelse(df$Age >= input$YearInv[1] &
                            df$Age <= input$YearInv[2], input$YearlyInv, 0)
    
    df$Addition <- ifelse((input$InitInvAge)-1 == df$Age, df$Addition + input$InInv, df$Addition)
    
    for(i in 1:53){
      
      df$Total[i+1] <- df$Total[i] * (100 + input$IntRate - if(input$WdAge<=df$Age[i]){input$WdRate}else{0}) / 100 + 
        df$Addition[i] 
      
      df$TotalWAddInv[i+1] <- df$TotalWAddInv[i] * (100 + input$IntRate - if(input$WdAge<=df$Age[i]){input$WdRate}else{0}) / 100 + 
        df$Addition[i] + 
        if(input$OneTimeInvAge==df$Age[i]){input$OneTimeInv}else{0} 
      
    }
    
    df$Total4Pct <- ifelse(input$WdAge > df$Age,0,df$Total * input$WdRate / 100)
    df$TotalWAddInv4Pct <- ifelse(input$WdAge>df$Age,0,df$TotalWAddInv * input$WdRate / 100)
    
    return(df)
    
  })
  
  output$InvTotal <- renderPlotly({
 
  ggplotly(
    ggplot(df(), aes(x=Age)) + 
      geom_line(aes(y=Total), color = "black") + 
      geom_line(aes(y=TotalWAddInv), color = "dark blue", size = 2) +
      scale_y_continuous(labels = scales::comma, limits = c(0,5000000)) + 
      scale_x_continuous(breaks = c(18,25,30,35,40,45,50,55,60,65,70)) +
      theme_minimal() + 
      ggtitle("Portfolio Total") +
      labs(y = "Dollars"))
  
  })
  
  output$Inv4Pct <- renderPlotly({

  
  p<-  ggplotly(
    ggplot(df(), aes(x=Age)) + 
      geom_line(aes(y=Total4Pct), color = "black") + 
      geom_line(aes(y=TotalWAddInv4Pct), color = "dark blue", size = 2) +
      scale_y_continuous(labels = scales::comma, limits = c(0,5000000*.04)) + 
      scale_x_continuous(breaks = c(18,25,30,35,40,45,50,55,60,65,70)) +
      theme_minimal() + 
      ggtitle("Amount Withdrawn") +
      labs(y = "Dollars"))
    
  })
  
})
