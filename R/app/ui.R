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
    
    tabItems(
      tabItem(tabName = "tab_1",
              HTML("hello world")),
      tabItem(tabName = "tab_2",
              HTML("this is")),
      tabItem(tabName = "tab_3",
              HTML("Greg"))
    )
    
    
  )
  
)