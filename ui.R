shinyUI(pageWithSidebar(
  headerPanel('NBA Visualization: Shot Data'),
  sidebarPanel(
    uiOutput('playerChoices'),
    actionButton('makePlot', 'Show')
  ),
  mainPanel(
    textOutput("position"),
    textOutput("number"),
    plotOutput("shotPlot")
  )
))