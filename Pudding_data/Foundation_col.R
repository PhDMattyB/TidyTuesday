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

numbers = df$allNumbers 


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
  
