
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
  
  data_gathered <- data %>%
    select(date, m2, y2) %>%
    gather(key="type", value="value", -date) %>%
    mutate(type = as.factor(type))

# source ui ---------------------------------------------------------------
  script <- getURL ("https://raw.githubusercontent.com/unimi-dse/8a65fae3/master/modules/ui.R",
                    ssl.verifypeer = FALSE)
  eval(parse(text = script))

# server side -------------------------------------------------------------
server <- function(input, output) { 
  output$distPlot <- renderPlot({
    ggplot(data_gathered, aes(x=date, y=value, col = type)) +
      geom_line()
  })
}
  
  
# run app -----------------------------------------------------------------
  runApp( shinyApp(ui, server), launch.browser = T )

}


