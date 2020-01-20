library(shinydashboard)
library(shiny)
library(tidyverse)
library(plotly)
library(shinycssloaders)

ui <- dashboardPage(
  
  dashboardHeader(),
  dashboardSidebar(
    
    sidebarMenu(
      menuItem("tab_1", tabName = "tab_1", icon=icon("home")),
      menuItem("tab_2", tabName = "tab_2", icon=icon("chart-line")), 
      menuItem("tab_3", tabName = "tab_3")
    )
  ),
  dashboardBody(
    
    # css
    tags$head(tags$style(HTML('
      .tab-content {
        margin-top: 30px;
        margin-bottom: 30px;
        margin-right: 50px;
        margin-left: 50px;
      }
      '))),

    tabItems(
      tabItem(tabName = "tab_1",
              HTML("
                   <h1>Time Series Project<br>
                   Analysis on the Term Structure of Interest Rates</h1>
                   <h2>Author: <font color=\"#00ccff\">Gregorio Saporito</font></h2>
                   <h3><font color=\"gray\">An analysis of US dollar LIBOR interbank rates,
                   observed at monthly frequency, for rates spanning the period 1961-2008</font></h3>
                   <h4><br>The Expectation hypothesis of the term structure of interest 
                   rates states that long-term rates are influenced by the expectations
                   that investors have on future short-term rates. To assess the validity
                   of this hypothesis a series of statistical analyses was run. Firstly, 
                   a cointegration test between short and long-term interest rates was run.
                   Subsequently, a vector error correction estimate, a Granger causality test,
                   and impulse response analysis were run to verify whether long-term rates
                   anticipate future movements of short rates. This research topic has
                   been extensively explored due to the level of insight that it could 
                   provide to central banks. Central banks mostly rely on short-term financial
                   instruments for the implementation of monetary policies. A better understanding
                   of the relations between short and long-term rates could help central banks
                   implement more effective policies. This research aims to empirically confirm
                   this framework of the yield curve through an analysis of US dollar LIBOR 
                   interbank rates.</h4>
                   ")),
      
      tabItem(tabName = "tab_2",
              HTML("<h2>Data Inspection</h2>"),
              withSpinner(plotlyOutput(outputId = "distPlot")),
              HTML("<h4>M2 and y2 are the main interest rates analysed in this report. M2 refers
                   to the US dollar LIBOR interbank rate with maturity 2 months, whereas y2 refers
                   to a 2-year maturity. As can be seen from figure 1, the yield curve is not 
                   inverted since long-term rates tend to lay above short-term ones. This suggests
                   long-term rates have a larger yield due to a risk premium, in line with the 
                   expectation hypothesis(Shiller R.J., 1979). Nevertheless, the presence of some
                   outliers is worth noting. For example, during the 2007 financial crisis an 
                   inversion of the yield curve occurred, leading to a scenario where short-term
                   investments had higher yields than long-term ones.</h4>
                   <h2>Interest Rates are I(1)</h2>"),
              fluidRow(
                column(6,
                  plotOutput("table_1")
                ),
                column(6,
                  plotOutput("table_2")
                )
              )
              ),
      
      tabItem(tabName = "tab_3",
              HTML("Greg"))
    )
  )
)