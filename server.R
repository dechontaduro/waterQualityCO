library(shiny)
library(ggplot2)

#'Prepare data
#'include file that contains prepare data code
source('prepareData.R', local=TRUE)

shinyServer(function(input, output) {
  output$plotWP1 <- renderPlot({
    #'Plot
    #'Plot bloxplot to index risk of water quality across departments in Colombia
    #'In UI you can select year of data.
    #'Addicionaly, put rectangles to emphatized levels of risk (no risk, low, medium, high and Nonviable)
    
    ggplot(subset(waterQualityColombia,ano == input$radioAnio), aes(departamento, promedio_irca)) + 
      geom_boxplot(aes(fill = departamento), show.legend = FALSE) +
      annotate("rect", xmin = -Inf, xmax = Inf,   ymin = -Inf, ymax = levelWQ[[1]][2], fill = colLevel[1], alpha=alphaLevel) +
      annotate("text", x = 1.3, y = levelWQ[[1]][2], label = "No risk")+
      annotate("rect", xmin = -Inf, xmax = Inf,   ymin = levelWQ[[1]][2], ymax = levelWQ[[1]][3], fill = colLevel[2], alpha=alphaLevel) +
      annotate("text", x = 1.3, y = levelWQ[[1]][3], label = "Low")+
      annotate("rect", xmin = -Inf, xmax = Inf,   ymin = levelWQ[[1]][3], ymax = levelWQ[[1]][4], fill = colLevel[3], alpha=alphaLevel) +
      annotate("text", x = 1.3, y = levelWQ[[1]][4], label = "Medium")+
      annotate("rect", xmin = -Inf, xmax = Inf,   ymin = levelWQ[[1]][4], ymax = levelWQ[[1]][5], fill = colLevel[4], alpha=alphaLevel) +
      annotate("text", x = 1.3, y = levelWQ[[1]][5], label = "High")+
      annotate("rect", xmin = -Inf, xmax = Inf,   ymin = levelWQ[[1]][5], ymax = Inf, fill = colLevel[5], alpha=alphaLevel) +
      annotate("text", x = 1.3, y = levelWQ[[1]][6], label = "Nonviable")+
      theme(axis.text.x = element_text(angle=60, hjust=1))+
      ylab("Index risk water quality")+
      xlab("Departments")
  })
})
