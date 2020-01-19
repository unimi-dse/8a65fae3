
hello_g <- function() {
  print("Hello, world! This is Greg")
}

runIR <- function() {
  
  library(shiny)
  library(shinydashboard)
  library(RCurl)
  library(tidyverse)


# read data ---------------------------------------------------------------
  d <- getURL("https://raw.githubusercontent.com/unimi-dse/8a65fae3/master/data/term_structure.csv")
  data <- read_csv(d)

# source ui ---------------------------------------------------------------
  script <- getURL ("https://raw.githubusercontent.com/unimi-dse/8a65fae3/master/modules/ui.R",
                    ssl.verifypeer = FALSE)
  eval(parse(text = script))

# server side -------------------------------------------------------------
  server <- function(input, output) { }
  
  
# run app -----------------------------------------------------------------
  runApp( shinyApp(ui, server), launch.browser = T )

}


