shinyUI(pageWithSidebar(
  headerPanel('NBA Visualization: Shot Data'),
  sidebarPanel(
    uiOutput('playerChoices'),
    actionButton('makePlot', 'Show')
  ),
  mainPanel(
    h2(textOutput("position"), align = "center"),
    h3(textOutput("number"), align = "center"),
    plotOutput("shotPlot")
  )
))