# This code was my first attempt at using the maps package. I pulled the world data set to get the longitude and
# latitude for the entire world.I took a dataset off Kaggle of Olympians from 1896 to 2016.
# I utilized SQL to join the datasets based on country. Next, I used ggplot to generate a polygon plot
# of the distrubutions of medal counts in countries from 1896 to 2016. 

#For further development of this code, I need to figure out how to pull in the United States. In the Olympics dataset,
# United States is stored as USA. In the world dataframe, United States is stored as United States. 


library(dplyr)
library(ggplot2)
library(maps)
library(sqldf)

events = read.csv('athlete_events.csv') #Took off of Kaggle 
world = map_data("world") #From the maps package 

 
nations = sqldf("SELECT Team, Count(Medal) AS m
              FROM events
              GROUP BY Team
              ORDER BY m
              ") #Medal Count for each country 

count = sqldf("SELECT *
              FROM world
              INNER JOIN nations ON team = region
              ") #Join world dataframe with medel 

#Polygon plot of world map for medal count 
ggplot(count, aes(x=long, y=lat, group = group, fill = m)) + 
  geom_polygon(colour = "white") + scale_fill_continuous(low = "lightgreen", high = "darkgreen", guide="colorbar") +
  labs(fill = "Legend" ,title = "Distribution of Medal Count from 1896 to 2016", x="", y= "") +
  scale_y_continuous(breaks=c()) + scale_x_continuous(breaks=c()) 




