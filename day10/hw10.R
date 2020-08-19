#Jacob Braslaw
#08/18/2020
#Daily Assignment 10

library(tidyverse)
library(sf)
`%notin%` <- Negate(`%in%`)
CONUS<- USAboundaries::us_states() %>%
  filter(state_name %notin% c("Alaska", "Hawaii", "Puerto Rico")) %>%
  st_combine() %>%
  st_cast("MULTILINESTRING")
plot(CONUS, col = "red")
