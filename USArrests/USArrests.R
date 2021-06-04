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

## Load the data and clean it
data('USArrests')

## splitting out the states because that info will disappear when
## the data is converted to a tibble
states = USArrests %>% 
  rownames() %>% 
  as_tibble()

## Add the information back in
clean_data = bind_cols(USArrests, 
                       states) %>% 
  as_tibble() %>% 
  rename(State = value)%>% 
  mutate(State = tolower(State)) ## lowercase matches map data

## calculate mean lat and longs for each state
mean_map_data = map_data('state') %>% 
  as_tibble() %>% 
  group_by(region) %>% 
  summarise(mean_lat = mean(lat),
            mean_long = mean(long)) %>% 
  rename(State = region)

## full data set
clean_data = inner_join(clean_data, 
          mean_map_data) %>% 
  select(-UrbanPop) %>% 
  group_by(State)

## map of the US
us_map_data = map_data('state') %>% 
  as_tibble()

## remove all axes
theme_set(theme_void())

## colour palette
col_pal = c('#034C8C', 
            '#04BF7B', 
            '#D7F205')

## Actual plot
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
       fill = 'Crime')+
  scale_fill_manual(values = col_pal)+
  geom_scatterpie(data = clean_data, 
                  aes(x = mean_long, 
                      y = mean_lat, 
                      group = State), 
                  pie_scale = 1, 
                  cols = colnames(clean_data[,c(1:3)]))+
  coord_fixed()+
  theme(legend.position = 'bottom', 
        legend.title = element_text(size = 12, 
                                    face = 'bold'), 
        legend.text = element_text(size = 10))
