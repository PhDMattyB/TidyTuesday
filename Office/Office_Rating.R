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

pal = c('#9082FF',
        '#FFCC8F', 
        '#759CFF', 
        '#FFE85C',
        '#29BAFF',
        '#E67CFF',
        '#29FFAD',
        '#759CFF',
        '#BBFF5C')

data_fixed %>% 
  group_by(season) %>% 
  ggplot()+
  geom_point(aes(x = season, 
                 y = imdb_rating, 
                 col = as.factor(season)),
             size = 2)+
  geom_smooth(aes(x = season, 
                  y = imdb_rating), 
              method = 'loess', 
              col = 'white', 
              size = 2)+
  labs(x = 'Season', 
       y = 'IMDB Rating')+
  scale_color_manual(values = pal)+
  # theme_classic()+
  theme_dark()+
  scale_x_continuous(breaks = seq(1, 9, by = 1))+
  theme(axis.title = element_text(size = 14), 
        axis.text = element_text(size = 12), 
        axis.ticks = element_line(size = 1), 
        axis.line = element_line(size = 1),
        legend.position = 'none',
        panel.grid = element_blank())
