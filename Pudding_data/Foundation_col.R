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
min(cat_df$lightness)
max(cat_df$lightness)
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
  ggplot(aes(x = category1, 
             y = lightness)) +
  # geom_point(aes(col = lightness))
  geom_violin()+
  geom_boxplot() %>% 
  facet_grid()

