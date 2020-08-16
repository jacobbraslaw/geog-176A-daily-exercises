#Jacob Braslaw
#day 08 exercise
#08/15/2020

#load covid data
library(tidyverse)
library(zoo)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

head(covid, 5)

#state of interest
 state.intrest = "New Mexico"

#filter data
RI<-covid %>%
  filter(state==state.intrest) %>%
  group_by (date) %>%
  summarize(totalCases=sum(cases)) %>%
  ungroup() %>%
  mutate(newCases = totalCases-lag(totalCases)) %>%
  mutate(roll7=rollmean(newCases,7,fill = NA,alight="right"))
RI

#plot data
casePlot<- ggplot(data=RI, aes(x=date))+
  geom_col(aes(y=newCases), col="lightblue")+
  geom_line(aes(y=roll7), col="blue")+
  labs(x = "Date", y = "Number of Cases",
       title = paste("New Cases by Day with Rolling 7 Day Average of ", state.intrest),
       caption = "Data: NY Times")
#save plot
casePlot
ggsave(plot = casePlot, file = "day08/08LAGPlot.png")
