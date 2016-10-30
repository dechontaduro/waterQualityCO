library(shiny)

shinyUI(fluidPage(
  #'Layout
  #'Only have 2 elements using layout column, it's responsive
  titlePanel("Index risk of Human Water Consumption in Colombia"),
  column(3
        , radioButtons("radioAnio", label = "Year", choices = c("2012","2015"))
  ),
  column(12
         , plotOutput('plotWP1')
  )
))