
library(ggplot2)
library(dplyr)



library(shiny)

shinyServer(function(input, output) {

    df <- reactive({
      
      df <- data.frame(Age = 17:101,
                 Total = 0, 
                 TotalWAddInv = 0,
                 Addition = 0)
      
      df$Addition <- ifelse(df$Age >= input$YearInv[1] &
                            df$Age <= input$YearInv[2], input$YearlyInv, 0)
      
      for(i in 1:84){
        
        df$Total[i+1] <- df$Total[i] * (100 + input$IntRate) / 100 + df$Addition[i] +
                                   if(input$InitInvAge==df$Age[i]){input$InInv}else{0}
        
        df$TotalWAddInv[i+1] <- df$TotalWAddInv[i] * (100 + input$IntRate) / 100 + df$Addition[i] + 
                                   if(input$InitInvAge==df$Age[i]){input$InInv}else{0} +
                                   if(input$OneTimeInvAge==df$Age[i]){input$OneTimeInv}else{0} 
        
      }
      
      df$Total4Pct <- df$Total * .04
      df$TotalWAddInv4Pct <- df$TotalWAddInv * .04
      
      return(df)
      
    })

    output$InvTotal <- renderPlot({
      
      ggplot(df(), aes(x=Age)) + 
        geom_line(aes(y=Total),color = "red") + 
        geom_line(aes(y=TotalWAddInv),color = "blue") +
        scale_y_continuous(labels = scales::comma, limits = c(0,10000000)) + 
        scale_x_continuous(breaks = c(18,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100))
      
    })
      
     output$Inv4Pct <- renderPlot({
        
        ggplot(df(), aes(x=Age)) + 
          geom_line(aes(y=Total4Pct),color = "red") + 
          geom_line(aes(y=TotalWAddInv4Pct),color = "blue") +
          scale_y_continuous(labels = scales::comma, limits = c(0,200000)) + 
          scale_x_continuous(breaks = c(18,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100))
      
      
      
    })
    
})



