##################################################################
## Combining map data with pie charts
##
## Matt Brachmann (PhDMattyB)
##
## 2021-06-04
##
##################################################################

## Load the data manipulation work horse
library(tidyverse)
library(maps)
library(scatterpie)
library(janitor)

# reproducible example ----------------------------------------------------
# quakes
# 
# quakes %>% 
#   as_tibble() %>% 
#   arrange(long)
# 
# 
# Japan = map_data('world') %>% 
#   filter(region == 'Japan') %>% 
#   as_tibble()

data('USArrests')
states = USArrests %>% 
  rownames() %>% 
  as_tibble()

clean_data = bind_cols(USArrests, 
                       states) %>% 
  as_tibble() %>% 
  rename(State = value)%>% 
  mutate(State = tolower(State))


mean_map_data = map_data('state') %>% 
  as_tibble() %>% 
  group_by(region) %>% 
  summarise(mean_lat = mean(lat),
            mean_long = mean(long)) %>% 
  rename(State = region)

clean_data = inner_join(clean_data, 
          mean_map_data) %>% 
  select(-UrbanPop) %>% 
  group_by(State)

us_map_data = map_data('state') %>% 
  as_tibble()

theme_set(theme_void())

col_pal = c('#034C8C', 
            '#04BF7B', 
            '#D7F205')

ggplot(us_map_data)+
  geom_map(data = us_map_data, 
           map = us_map_data, 
           aes(x = long, 
               y = lat, 
               map_id = region), 
           col = 'white', 
           fill = '#9BA7BF')+
  labs(x = 'Longitude', 
       y = 'Latitude', 
       fill = 'Arrested')+
  scale_fill_manual(values = col_pal)+
  geom_scatterpie(data = clean_data, 
                  aes(x = mean_long, 
                      y = mean_lat, 
                      group = State), 
                  pie_scale = 1, 
                  cols = colnames(clean_data[,c(1:3)]))+
  coord_fixed()
