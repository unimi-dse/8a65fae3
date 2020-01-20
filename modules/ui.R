library(shinydashboard)
library(shiny)

ui <- dashboardPage(
  
  dashboardHeader(),
  dashboardSidebar(
    
    sidebarMenu(
      menuItem("tab_1", tabName = "tab_1"),
      menuItem("tab_2", tabName = "tab_2"), 
      menuItem("tab_3", tabName = "tab_3")
    )
  ),
  dashboardBody(
    
    # css
    tags$head(tags$style(HTML('
      .tab-content {
        margin-top: 30px;
        margin-bottom: 30px;
        margin-right: 30px;
        margin-left: 30px;
        color:red;
      }
      '))),

    
    tabItems(
      tabItem(tabName = "tab_1",
              HTML("<h1>hello world<h1>")),
      tabItem(tabName = "tab_2",
              HTML("this is")),
      tabItem(tabName = "tab_3",
              HTML("Greg"))
    )
  )
)