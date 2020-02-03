#' Shiny app with exploratory analysis of the term structure of interest rates
#' 
#' The function works with no arguments.
#'
#' @return Runs the Shiny app retreiving the data, running the analysis and showing the report with interactive visualisations.
#' 
#' Dataset term_structure
#'
#' This is a dataset containing LIBOR interbank interest rates
#' 
#' @export
runIR <- function() {

# run app -----------------------------------------------------------------
  shiny::runApp(system.file("shiny/IR", package = "interestrates"), launch.browser = T)

}