library ("tidyverse")

bikedata <- read.csv("~/Project A1 BIO302/03.csv")

bikedata <- as_tibble(bikedata)
bikedata

bikedata %>% count (start_station_name) %>% arrange (desc(n))

bikedata %>%  (start_sation_name)

install.packages ("ggplot2")
library ("ggplot2")
library ("tidyverse")

##- Which is the most popular starting station? Mollendalsplass  1502

bikedata %>% count (start_station_name) %>% arrange (desc(n))  
bikedata %>% count (end_station_name) %>% arrange (desc(n))

##- Plot the number of hires and returns from each station
bikedata %>% 
  gather (key = variable, value = Stations, start_station_name, end_station_name) %>% count (variable, Stations) %>% 
  ggplot (aes(y=n, x=Stations, fill=variable)) + geom_col (position=position_dodge())

##Which is the most popular pair of start and end stations?
 
bikedata %>% count (start_station_name) %>% arrange (desc(n)) %>% slice (1:2)  
bikedata %>% count (end_station_name) %>% arrange (desc(n)) %>% slice (1:2)

bikedata %>% count(start_station_name, end_station_name) %>%  arrange (desc(n)) %>% slice (1:2)

## - What was the longest/shortest duration of hire? 
bikedata %>% arrange (desc(duration)) %>% slice (1:1)
bikedata %>% arrange (duration) %>%  slice (1:1)

##Plot the distribution of hire duration
bikedata %>% 
  ggplot (aes(x=duration)) + geom_histogram() + xlim (0,3600)

#xlim function will cut my data, set a minimum and a maximum 

##What is the median duration of hire from each station?

bikedata %>% 
  group_by(start_station_name) %>% 
  summarise (median(duration))

##Map this information 
map <- bikedata %>% 
  group_by(start_station_name, start_station_latitude, start_station_longitude) %>% 
  summarise (MedianDuration = median(duration)) 
  ggplot (map, aes(x= start_station_latitude, y=start_station_longitude)) + geom_point(aes(size=MedianDuration)) + xlim(60.35, 60.40) + ylim (5.28,5.38)

##Are there any significant difference in duration between stations? We do an Anova test. 

fit.lm <- lm (duration~start_station_latitude, data = bikedata)
anova (fit.lm)

#my is not signficant :( I have a very big outlier. No significant differences between duration between stations. 

##How far does a typical cyclist travel?

##What is the relationship between distance travelled and time taken?

##How fast was the fastest cyclist (for simplicity assume a straight line of travel)

