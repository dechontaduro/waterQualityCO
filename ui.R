library(shiny)

shinyUI(fluidPage(
  #'Layout
  #'Only have 2 elements using layout column, it's responsive
  titlePanel("Index risk of Human Water Consumption in Colombia"),
  column(12
         , p("Colombia has a website where public entities can publish data <https://www.datos.gov.co> based in <https://socrata.com/>
             For this example <https://github.com/dechontaduro/waterQualityCO> used Index risk of Human Water Consumption in Colombia (SIVICAP).")
  ),
  column(12
         , p("Colombia has in average a high level of risk to contracting diseases due to quality of water, this index measure it.")
  ),
  column(12
         , p("You can chage year of measure to compare changes between them.")
  ),
  column(3
        , radioButtons("radioAnio", label = "Year", choices = c("2012","2015"))
  ),
  column(12
         , plotOutput('plotWP1')
  )
))