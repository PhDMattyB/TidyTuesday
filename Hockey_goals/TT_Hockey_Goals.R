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

season_goals %>% 
arrange(penalty_min) %>%
  select(penalty_min) %>% 
  View()


ggplot(data = season_goals,
       aes(x = yr_start, 
           y = penalty_min)) +
  scale_color_manual(values = wes_palette('Darjeeling1', 
                                          type = 'continuous'))+
  geom_hex(aes(col = penalty_min))+  
  labs(x = 'Year season started', 
       y = 'Penalty minutes') +
  theme(panel.grid = element_blank(), 
        axis.title = element_text(size = 15), 
        axis.text = element_text(size = 15))
  
  pal <- wes_palette("Zissou1", 100, type = "continuous")
  ggplot(heatmap, aes(x = X2, y = X1, fill = value)) +
    geom_tile() + 
    scale_fill_gradientn(colours = pal) + 
    scale_x_discrete(expand = c(0, 0)) +
    scale_y_discrete(expand = c(0, 0)) + 
    coord_equal() 
