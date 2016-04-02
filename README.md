#NBA Shot Data Visualization: From Scratch to an App in 60 Minutes

## The world of sports data is vast, and significant quantities of information are publicly available online. 
In this workshop, we will scrape data from the web, process it in R, and guide participants through the basics of
making a web app in R. By the end of the workshop, each participant will have made a visualization of player data 
as a web application. Below is what the final product will look like:

![Image of Final Product](/final_product.png)

## Important!
Before proceeding, be sure to open the file 'NBAvis_presentation.pptx' and go to the "Resource dump" slide. You'll find a lot of useful information and answers there.

## Necessary packages to install
Run the following commands if you don't have the packages installed already.

Python: run in terminal/command line

```
pip install beautifulsoup4
pip install re
pip install csv
pip install numpy
```

R: run in RStudio
```
install.packages(c('rjson', 'RCurl', 'ggplot2', 'jpeg', 'grid', 'shiny'))
```

## Important links
Data scraped from [NBA Stats](http://www.nba.com/warriors/stats)

Visualization code adapted from [The Data Game](http://thedatagame.com.au/2015/09/27/how-to-create-nba-shot-charts-in-r/)
