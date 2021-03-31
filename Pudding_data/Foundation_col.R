##############################
## Makeup shades data from the Pudding
##
## Matt Brachmann (PhDMattyB)
##
## 2021-03-30
##
##############################

## Load packages
library(tidyverse)
library(tidytuesdayR)
library(viridis)

## Considering we're plotting this, set the theme once
theme_set(theme_bw())

## Read in data
df = tidytuesdayR::tt_load(2021, 
                           week = 14)


ulta = df$ulta %>% 
  dplyr::select(brand,
                product, 
                description, 
                name, 
                imgAlt, 
                specific)

seph = df$sephora %>% 
  dplyr::select(brand, 
                product, 
                description, 
                name, 
                imgAlt, 
                specific)

shades = df$allShades %>% 
  dplyr::select(brand, 
                product, 
                description)


# Numbers dataset and plots -----------------------------------------------


numbers = df$allNumbers 

# light_scale_brand = numbers %>% 
#   na.omit(lightToDark) %>% 
#   distinct(brand, 
#            product, 
#            name, 
#            .keep_all = T) %>% 
#   group_by(brand) %>% 
#   summarise(percent = n()) %>% 
#   mutate(percent = percent/sum(percent)*100)

light_scale_TF = numbers %>% 
  na.omit(lightToDark) %>% 
  distinct(brand, 
           product, 
           name, 
           .keep_all = T) %>% 
  group_by(lightToDark) %>% 
  summarise(percent = n()) %>% 
  mutate(percent = percent/sum(percent)*100) 

light_scale_TF$lightToDark = gsub('TRUE', 
                      'True - 92.3%', 
                      light_scale_TF$lightToDark)

light_scale_TF$lightToDark = gsub('FALSE', 
                                  'False - 7.7%', 
                                  light_scale_TF$lightToDark)

no_light_scale = numbers %>% 
  na.omit(lightToDark) %>% 
  distinct(brand, 
           product, 
           name, 
           .keep_all = T) %>% 
  group_by(brand) %>% 
  filter(lightToDark == FALSE) %>% 
  distinct(brand)

labels = light_scale_TF %>% 
  arrange(desc(lightToDark)) %>% 
  mutate(ypos = cumsum(percent) - 0.5*percent) %>% 
  mutate(end = 2 * pi * cumsum(percent)/sum(percent), 
         start = lag(end, 
                     default = 0), 
         middle = 0.5 * (start + end),  
         hjust = ifelse(middle > pi, 1, 0), 
         vjust = ifelse(middle < pi/2 | middle > 3 * pi/2, 0, 1))

pie_pal = c('#F2637E',
            '#0477BF')

pie_chart = light_scale_TF %>% 
  ggplot(aes(x = "", 
             y = percent, 
             fill = lightToDark))+
  geom_bar(stat = 'identity', 
           width = 1, 
           color = 'white')+
  coord_polar("y", 
              start = 0)+
  labs(fill = 'Light to Dark Scale')+
  # geom_text(data = labels, 
  #           aes(x = 1.05 * sin(middle), 
  #               y = 1.05 * cos(middle), 
  #               label = lightToDark, 
  #               hjust = hjust, 
  #               vjust = vjust))+
  geom_text(data = labels,
            aes(y = ypos,
                label = lightToDark,
                fontface = 'bold'),
            color = 'black',
            size = 3)+
  scale_fill_manual(values = pie_pal)+
  theme_void()+
  theme(legend.position = 'none')


# numbers %>% 
#   na.omit(lightToDark) %>% 
#   distinct(brand, 
#            product, 
#            name, 
#            .keep_all = T) %>% 
#   group_by(brand) %>% 
#   filter(lightToDark == TRUE) %>% 
#   distinct(brand)

# Category data and plot --------------------------------------------------
## Start with the category data set
## this one looks the most interesting
cat_df = df$allCategories %>% 
  dplyr::select(brand, 
                product, 
                name, 
                categories, 
                lightness) %>% 
  separate(col = categories, 
           paste0('category', 
                 1:3), 
           sep = ',', 
           extra = 'drop') %>% 
  group_by(category1)

## Check which ones are common and which ones are not
cat_df %>% 
  count(category1) %>% 
  arrange(n)

## quick summary stats
mean(cat_df$lightness)

cat_sum_stats = cat_df %>% 
  summarise(light_std = sd(lightness), 
            light_var = var(lightness), 
            light_min = min(lightness),
            light_max = max(lightness),
            light_mean = mean(lightness))


cat_df %>% 
  select(-category2, 
         -category3) %>%
  ggplot(aes(x = reorder(category1, lightness), 
             y = lightness)) +
    geom_jitter(aes(col = lightness), 
              width = 0.15, 
              size = 1)+
  geom_point(data = cat_sum_stats, 
             aes(x = category1, 
                 y = light_mean), 
             col = 'black', 
             size = 3)+
  geom_hline(yintercept = mean(cat_df$lightness), 
             # size = 2,
             linetype = 'dotted')+
  ylim(0, 1.00)+
  labs(y = 'Lightness', 
       col = 'Lightness')+
  scale_color_viridis(option = 'magma')+
  theme(
        panel.grid.major.y = element_blank(), 
        panel.grid.minor.y = element_blank(), 
        panel.grid.minor.x = element_blank(), 
        axis.title.x = element_blank(), 
        axis.text.x = element_text(size = 12,
                                   hjust = 1,
                                   angle = 45), 
        axis.title.y = element_text(size = 14), 
        axis.text.y = element_text(size = 12), 
        legend.position = 'none'
        )
  
