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


cat = df$allCategories %>% 
  dplyr::select(brand, 
                product, 
                name, 
                categories, 
                lightness)

## Step 1: data cleaning
## combine ulta and sephora data

clean_df = full_join(ulta, 
          seph, 
          by = c('brand', 
                 'product', 
                 'description', 
                 'name')) %>% 
  left_join(cat, 
            by = c('brand', 
                   'product')) %>%
  left_join(numbers, 
            by = c('brand', 
                   'product')) %>% 
  dplyr::select(brand, 
                product, 
                description, 
                name.x, 
                categories, 
                lightness.x, 
                lightToDark) 
  # distinct(product, 
  #          .keep_all = TRUE)

lightdark = combo_df %>% 
  na.omit()


