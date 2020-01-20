
hello_g <- function() {
  print("Hello, world! This is Greg")
}

runIR <- function() {

dependencies <- c("shiny", "shinydashboard", "RCurl", "tidyverse")
  
for (x in dependencies) {
  if(x %in% rownames(installed.packages()) == T) {
    library(x, character.only = T)
  } else {
    install.packages(x)
    library(x, character.only = T)
    Sys.sleep(5)
  }
}

# read data ---------------------------------------------------------------
  d <- getURL("https://raw.githubusercontent.com/unimi-dse/8a65fae3/master/data/term_structure.csv")
  data <- read_csv(d)

# source ui ---------------------------------------------------------------
  script <- getURL ("https://raw.githubusercontent.com/unimi-dse/8a65fae3/master/modules/ui.R",
                    ssl.verifypeer = FALSE)
  eval(parse(text = script))

# server side -------------------------------------------------------------
server <- function(input, output) { 
  
  output$plot_1 <- renderPlot({
    plot(iris)
  })
  
}
  
  
# run app -----------------------------------------------------------------
  runApp( shinyApp(ui, server), launch.browser = T )

}


