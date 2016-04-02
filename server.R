
library(grid)
library(jpeg)
library(rjson)
library(RCurl)
setwd('~/Documents/Projects/NCAA/NBA')

player_data = read.csv('player_data.csv', header = F)
colnames(player_data) = c('Name', 'ID', 'Position', 'Number')

shinyServer(function(input, output, session) {

  output$playerChoices <- renderUI({
    selectInput("player_name", "Player Names", as.list(as.character(player_data$Name))) 
  })
  
  output$position <- renderText ({
    playerName = input$player_name
    position = player_data$Position[which(player_data$Name == playerName)[1]]
    
    paste("Position:", position)
  })
  
  output$number <- renderText({
    playerName = input$player_name
    number = player_data$Number[which(player_data$Name == playerName)[1]]
    
    paste("Number:", number)
  })
  
  output$backgroundCourt <- renderImage({

      filename = normalizePath(file.path('nba_court.jpg'))
      list(src = filename,
           alt = filename)
  }, delete = FALSE)
  
  getData <- reactive({
    playerName = input$player_name
    playerID = player_data$ID[which(player_data$Name == playerName)[1]]
    
    print(playerName)
    print(playerID)
    
    shotURL <- paste("http://stats.nba.com/stats/shotchartdetail?CFID=33&CFPARAMS=2014-15&ContextFilter=&ContextMeasure=FGA&DateFrom=&DateTo=&GameID=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerID=",playerID,"&PlusMinus=N&Position=&Rank=N&RookieYear=&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=&mode=Advanced&showDetails=0&showShots=1&showZones=0", sep = "")
    
    # import from JSON
    shotData <- fromJSON(file = shotURL, method="C")
    
    # unlist shot data, save into a data frame
    shotDataf <- data.frame(matrix(unlist(shotData$resultSets[[1]][[3]]), ncol=21, byrow = TRUE))
    
    # shot data headers
    colnames(shotDataf) <- shotData$resultSets[[1]][[2]]
    
    # covert x and y coordinates into numeric
    shotDataf$LOC_X <- as.numeric(as.character(shotDataf$LOC_X))
    shotDataf$LOC_Y <- as.numeric(as.character(shotDataf$LOC_Y))
    shotDataf$SHOT_DISTANCE <- as.numeric(as.character(shotDataf$SHOT_DISTANCE))
    
    shotDataf
  })
  
  # Combine the selected variables into a new data frame
  output$shotPlot <- renderPlot({
    
    p = ggplot(getData(), aes(x=LOC_X, y=LOC_Y)) + 
      annotation_custom(court, -250, 250, -50, 420) +
      geom_point(aes(colour = SHOT_ZONE_BASIC, shape = EVENT_TYPE)) +
      xlim(-250, 250) +
      ylim(-50, 420) + scale_shape_manual(values = c(4,16))
    
    print(p)
  })
  
})