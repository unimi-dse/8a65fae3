
hello_g <- function() {
  print("Hello, world! This is Greg")
}

runIR <- function() {
  
  library(shiny)
  library(shinydashboard)
  runApp("R/app", launch.browser = T)
  
}
