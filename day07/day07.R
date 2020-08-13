#Jacob Braslaw
#day 07 exercise
#08/13/2020

#read in data
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

#create new data frame
region<- data.frame(state_abbr = state.abb, state = state.name, state_reg = state.region)

#looking at data to see my variables
head(covid, 7)
head(region, 7)

#Trying left join
inner_join(covid, region, by = "state") %>%
  group_by(state_reg, date) %>%
  summarize(cases = sum(cases, na.rm = TRUE),deaths= sum(deaths))  %>%
  pivot_longer(cols = c("cases","deaths")) %>%
  ggplot(aes(x=date, y=value)) +
  geom_line(aes(col = state_reg))+
  labs(x = "Date", y = "# of People",
       title = "Cases and Deaths by Region",
       caption = "Data: NY Times")+
  facet_grid(name~state_reg, scales = "free_y")+
ggsave(plot = last_plot(), file= "day07/img/07Plot.png")








