#' @export
hello_g <- function() {
  print("Hello, world! This is Greg")
}

#' @export
runIR <- function() {

dependencies <- c("shiny", "shinydashboard", "RCurl", "tidyverse", "plotly", "shinycssloaders",
                  "grid", "gridExtra", "aTSA", "vars", "broom")
  
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
  
  data_gathered <- data[,c("date", "m2", "y2")] %>%
    gather(key="type", value="value", -date) %>%
    mutate(type = as.factor(type))

# adf tests --------------------------------------------------------------
  p <- adf.test(data$m2, nlag = 3)
  
  p_1 <- data.frame(p$type1) %>%
    mutate(type="no drift no trend ") %>% 
    bind_rows(
      data.frame(p$type2) %>%
        mutate(type="with drift no trend")
    ) %>%
    bind_rows(
      data.frame(p$type3) %>%
        mutate(type="with drift and trend")
    )
  
  q <- adf.test(data$y2, nlag = 3)
  
  q_1 <- data.frame(q$type1) %>%
    mutate(type="no drift no trend ") %>% 
    bind_rows(
      data.frame(q$type2) %>%
        mutate(type="with drift no trend")
    ) %>%
    bind_rows(
      data.frame(q$type3) %>%
        mutate(type="with drift and trend")
    )
  
  spreads <- data %>% 
    mutate(spreads = y2-m2)
  
  z <- adf.test(spreads$spreads, nlag = 3)
  
  z_1 <- data.frame(z$type1) %>%
    mutate(type="no drift no trend ") %>% 
    bind_rows(
      data.frame(z$type2) %>%
        mutate(type="with drift no trend")
    ) %>%
    bind_rows(
      data.frame(z$type3) %>%
        mutate(type="with drift and trend")
    )
  

# cointegration test ------------------------------------------------------
  
  # linear regression model
  mod <- lm(y2 ~ m2, data = data)
  dflm <- augment(mod) %>%
    mutate(date=data$date)
  
  adfred <- adf.test(dflm$.resid, nlag = 3)
  
  adfred_1 <- data.frame(adfred$type1) %>%
    mutate(type="no drift no trend ") %>% 
    bind_rows(
      data.frame(adfred$type2) %>%
        mutate(type="with drift no trend")
    ) %>%
    bind_rows(
      data.frame(adfred$type3) %>%
        mutate(type="with drift and trend")
    )
  
# source ui ---------------------------------------------------------------
  script <- getURL ("https://raw.githubusercontent.com/unimi-dse/8a65fae3/master/modules/ui.R",
                    ssl.verifypeer = FALSE)
  eval(parse(text = script))

# server side -------------------------------------------------------------
server <- function(input, output) { 
  
  output$distPlot <- renderPlotly({
    plot <- ggplot(data_gathered, aes(x=date, y=value, col = type)) +
      geom_line()
    ggplotly(plot)
  })
  
  output$table_1 <- renderPlot({    
    grid.table(p_1, theme= ttheme_default(base_size = 18) )
  })
  
  output$table_2 <- renderPlot({ 
    grid.table(q_1, theme= ttheme_default(base_size = 18) )
  })
  
  output$table_3 <- renderPlot({
    grid.table(z_1, theme= ttheme_default(base_size = 18) )
  })
  
  output$spreadsplot <- renderPlotly({
    plot <- ggplot(spreads, aes(x=date, y=spreads)) +
      geom_line()
    ggplotly(plot)
  })
  
  output$lm_plot <- renderPlotly({
    plot_lm <- ggplot(dflm, aes(x = m2, y = y2)) +
      geom_smooth(method = "lm", se = FALSE, color = "lightgrey") +
      geom_segment(aes(xend = m2, yend = .fitted), alpha = .2) +
      geom_point(aes(color = abs(.resid))) + # size also mapped
      scale_color_continuous(low = "black", high = "red") +
      guides(color = FALSE, size = FALSE)
    ggplotly(plot_lm)
  })
  
  output$lm_resid <- renderPlotly({
    plot <- ggplot(dflm, aes(x = date, y = .resid)) + 
      geom_line()
    ggplotly(plot)
  })
  
  
}
  
  
# run app -----------------------------------------------------------------
  runApp( shinyApp(ui, server), launch.browser = T )

}

