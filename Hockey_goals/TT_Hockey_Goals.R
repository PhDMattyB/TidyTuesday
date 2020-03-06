##############################
## Tidy Tuesday Hockey Goals
##
## Matt Brachmann (PhDMattyB)
##
## 2020-03-06
##
##############################

dir.create('~/PhD/GitHub/TidyTuesday')
dir.create('~/PhD/GitHub/TidyTuesday/Hockey_goals')

setwd('~/PhD/GitHub/TidyTuesday/Hockey_goals')

library(wesanderson)
library(patchwork)
library(tidyverse)

theme_set(theme_bw())

## Read in data
# game_goals = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-03/game_goals.csv')
# top_250 = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-03/top_250.csv')
season_goals = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-03/season_goals.csv')

short_data = season_goals %>% 
  select(player, 
         rank,
         penalty_min, 
         yr_start, 
         total_goals)

ggplot(data = short_data,
       aes(x = yr_start, 
           y = penalty_min)) +
    geom_hex()+
  scale_fill_gradient(low = '#59B389', 
                       high = '#FFADA1')+
  labs(x = 'Year season started', 
       y = 'Penalty minutes') +
  theme(panel.grid = element_blank(), 
        axis.title = element_text(size = 15), 
        axis.text = element_text(size = 15))
  
