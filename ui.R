shinyUI(pageWithSidebar(
  headerPanel('NBA Visualization: Shot Data'),
  sidebarPanel(
    uiOutput('playerChoices'),
    actionButton('makePlot', 'Show')
  ),
  mainPanel(
    #imageOutput('backgroundCourt')
    plotOutput("shotPlot")
  )
))