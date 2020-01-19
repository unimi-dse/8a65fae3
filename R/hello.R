
hello_g <- function() {
  print("Hello, world! This is Greg")
}

runIR <- function() {
  install.packages("shinydashboard")
  library(shiny)
  library(shinydashboard)
  runApp("R/app", launch.browser = T)
  
}
