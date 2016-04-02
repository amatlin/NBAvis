
from bs4 import BeautifulSoup
import urllib, re, csv
from itertools import izip

stats_url = 'http://www.nba.com/warriors/stats'
r = urllib.urlopen(stats_url).read()

soup = BeautifulSoup(r)
print type(soup)

players = soup.find_all('div', class_ ='player-name__inner-wrapper')

def getName(player):
	allText = player.get_text()
	return(re.findall('\d+|\D+', allText)[0])

def getNumber(player):
	allText = player.get_text()
	return(re.findall('\d+|\D+', allText)[1])

def getPosition(player):
	allText = player.get_text()
	return(re.findall('\d+|\D+', allText)[2]).split(u"\x95")[1]


def getID(player):
	split_src = (player.find('img')['src']).split('/')
	return split_src[len(split_src)-1].split('.')[0]



names = [getName(player) for player in players]
ids = [getID(player) for player in players]
positions = [getPosition(player) for player in players]
numbers = [getNumber(player) for player in players]

print names, ids, positions, numbers

with open('player_data.csv', 'wb') as f:
    writer = csv.writer(f)
    writer.writerows(izip(names, ids, positions, numbers))

   