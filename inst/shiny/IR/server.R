library(shinydashboard)
library(tidyverse)
library(waiter)

# function to show console output in shiny
withConsoleRedirect <- function(containerId, expr) {
  # Change type="output" to type="message" to catch stderr
  # (messages, warnings, and errors) instead of stdout.
  txt <- capture.output(results <- expr, type = "output")
  if (length(txt) > 0) {
    shiny::insertUI(paste0("#", containerId), where = "beforeEnd",
                    ui = paste0(txt, "\n", collapse = "")
    )
  }
  results
}


# clean data --------------------------------------------------------------
data <- term_structure

data_gathered <- data[,c("date", "m2", "y2")] %>%
  gather(key="type", value="value", -date) %>%
  mutate(type = as.factor(type))

spreads <- data %>% 
  mutate(spreads = y2-m2)

# cointegration test ------------------------------------------------------

# linear regression model
mod <- lm(y2 ~ m2, data = data)
dflm <- broom::augment(mod) %>%
  mutate(date=data$date)

adfred <- aTSA::adf.test(dflm$.resid, nlag = 3)

# analysis ----------------------------------------------------------------

mysample <- data[, c("m2", "y2")]
# VARselect(mysample, lag.max = 10, type = "const")
cointtest <- urca::ca.jo(mysample, K=2, spec = "transitory", type="eigen")
# cajorls(cointtest)

server <- function(input, output, session) {
  
  Sys.sleep(2)
  waiter_hide()
  
  output$menu <- renderMenu({
    
    sidebarMenu(id="tabs",
                menuItem("Home", tabName = "tab_1", icon=icon("home")),
                menuItem("Inspection", tabName = "tab_2", icon=icon("search")),
                menuItem("Analysis", tabName = "tab_3", icon=icon("chart-line")),
                menuItem("Conclusion", tabName = "tab_4", icon=icon("calendar-check"))
    )
  })
  
  output$distPlot <- plotly::renderPlotly({
    plot <- ggplot(data_gathered, aes(x=date, y=value, col = type)) +
      geom_line()
    plotly::ggplotly(plot)
  })
  
  observe({
    withConsoleRedirect("adfm2", {
      aTSA::adf.test(data$m2, nlag = 3)
    })
  })
  
  observe({
    withConsoleRedirect("adfy2", {
      aTSA::adf.test(data$y2, nlag = 3)
    })
  })
  
  observe({
    withConsoleRedirect("adfspreads", {
      aTSA::adf.test(spreads$spreads, nlag = 3)
    })
  })
  
  output$spreadsplot <- plotly::renderPlotly({
    plot <- ggplot(spreads, aes(x=date, y=spreads)) +
      geom_line()
    plotly::ggplotly(plot)
  })
  
  output$lm_plot <- plotly::renderPlotly({
    plotly::ggplotly(
      ggplot(dflm, aes(x = m2, y = y2)) +
        geom_line(aes(y=.fitted), color="lightgrey") +
        geom_segment(aes(xend = m2, yend = .fitted), alpha = .2) +
        geom_point(aes(color = abs(.resid))) + # size also mapped
        scale_color_continuous(low = "black", high = "red") +
        guides(color = FALSE, size = FALSE)
    )
  })
  
  output$lm_resid <- plotly::renderPlotly({
    plot <- ggplot(dflm, aes(x = date, y = .resid)) + 
      geom_line()
    plotly::ggplotly(plot)
  })
  
  observe({
    withConsoleRedirect("console", {
      aTSA::adf.test(dflm$.resid, nlag = 3)
    })
  })
  
  observe({
    withConsoleRedirect("laglength", {
      print(vars::VARselect(mysample, lag.max = 10, type = "const"))
    })
  })
  
  observe({
    withConsoleRedirect("VEC", {
      print(urca::cajorls(cointtest))
    })
  })
  
  output$download <- downloadHandler(
    filename = function(){"term_structure.csv"}, 
    content = function(fname){
      write.csv(term_structure, fname)
    }
  )
  
  observeEvent(input$tabs,{
    shinyanimate::startAnim(session, 'effect_1', 'slideInUp')
  })
  observeEvent(input$tabs,{
    shinyanimate::startAnim(session, 'effect_2', 'slideInUp')
  })
  observeEvent(input$tabs,{
    shinyanimate::startAnim(session, 'effect_3', 'slideInUp')
  })
  observeEvent(input$tabs,{
    shinyanimate::startAnim(session, 'effect_4', 'slideInUp')
  })
  
}