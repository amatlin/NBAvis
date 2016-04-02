
# import necessary libraries
from bs4 import BeautifulSoup
import urllib, re, csv
from itertools import izip

# make our "soup"
stats_url = 'http://www.nba.com/warriors/stats'
r = urllib.urlopen(stats_url).read()
soup = BeautifulSoup(r)

# check that we read in successfully
print type(soup)

# use properties of NBA stats page to identify player divs
players = soup.find_all('div', class_ ='player-name__inner-wrapper')

# functions to extract fields from player divs
def getName(player):
	allText = player.get_text()
	return(re.findall('\d+|\D+', allText)[0]) # uses regular expressions

def getNumber(player):
	allText = player.get_text()
	return(re.findall('\d+|\D+', allText)[1])

def getPosition(player):
	allText = player.get_text()
	return(re.findall('\d+|\D+', allText)[2]).split(u"\x95")[1]

def getID(player):
	split_src = (player.find('img')['src']).split('/')
	return split_src[len(split_src)-1].split('.')[0]

# apply functions and make lists of player attributes
names = [getName(player) for player in players]
ids = [getID(player) for player in players]
positions = [getPosition(player) for player in players]
numbers = [getNumber(player) for player in players]

print names, ids, positions, numbers

# write to a new data file in CSV format
with open('player_data.csv', 'wb') as f:
    writer = csv.writer(f)
    writer.writerows(izip(names, ids, positions, numbers))

   