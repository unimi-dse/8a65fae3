library(shinydashboard)
library(shiny)
library(RCurl)

text <- getURL("https://raw.githubusercontent.com/unimi-dse/8a65fae3/master/modules/www/custom.css")
read.delim("https://raw.githubusercontent.com/unimi-dse/8a65fae3/master/modules/www/custom.css")

readtext(text)

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
    
    # # css
    # tags$head(tags$style(HTML('
    #   .tab-content {
    #     margin-top: 30px;
    #     margin-bottom: 30px;
    #     margin-right: 30px;
    #     margin-left: 30px;
    #     color:red;
    #   }
    #   '))),
    
    # css test
    tags$head(tags$style(HTML(
      
    )
    )),
    
    
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