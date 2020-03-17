##############################
## Tidytuesday Office
##
## Matt Brachmann (PhDMattyB)
##
## 2020-03-17
##
##############################
dir.create('~/PhD/GitHub/TidyTuesday/Office')

setwd('~/PhD/GitHub/TidyTuesday/Office/')

library(patchwork)
library(tidyverse)

data = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-17/office_ratings.csv')

split = str_split_fixed(data$air_date, '-', n = 3) %>% 
  as_tibble() %>% 
  rename(year = V1, 
         Month = V2, 
         Day = V3)

data_fixed = bind_cols(data, split)

data_fixed %>% 
  group_by(season) %>% 
  ggplot()+
  geom_point(aes(x = season, 
                 y = imdb_rating, 
                 col = season))+
  geom_smooth(aes(x = season, 
                  y = imdb_rating), 
              method = 'loess', 
              col = 'black')+
  labs(x = 'Season', 
       y = 'IMDB Rating')+
  theme_classic()+
  theme()
