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
library(patchwork)

## Considering we're plotting this, set the theme once
theme_set(theme_bw())

## Read in data
df = tidytuesdayR::tt_load(2021, 
                           week = 14)

# lightness per category description --------------------------------------

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


plot1 = cat_df %>% 
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
        # axis.title.y = element_text(size = 14), 
        axis.title.y = element_blank(),
        axis.text.y = element_text(size = 12), 
        legend.position = 'none'
        )
  
# Lightness per brand -----------------------------------------------------

cat_df2 = df$allCategories %>%
  select(brand, 
         # product, 
         name, 
         lightness) %>% 
  group_by(brand) %>% 
  filter(brand %in% sum_stats$brand)


sum_stats = cat_df2 %>% 
  summarise(light_mean = mean(lightness), 
            num = n()) %>% 
  filter(num > 100)


plot2 = cat_df2 %>% 
  ggplot(aes(x = lightness, 
             y = brand))+
  geom_jitter(aes(col = lightness), 
              width = 0.15, 
              size = 1)+
  geom_point(data = sum_stats, 
             aes(x = light_mean, 
                 y = brand), 
             col = 'black', 
             size = 4)+
  geom_vline(xintercept = mean(cat_df2$lightness), 
             linetype = 'solid', 
             size = 1.5)+
  xlim(0, 1.00)+
  labs(x = 'Lightness', 
       col = 'Lightness')+
  scale_color_viridis(option = 'magma')+
  theme(
    panel.grid.major.x = element_blank(), 
    panel.grid.minor.x = element_blank(), 
    panel.grid.minor.y = element_blank(), 
    axis.title.y = element_blank(), 
    axis.text.y = element_text(size = 12), 
    # axis.title.x = element_text(size = 14),
    axis.title.x = element_blank(),
    axis.text.x = element_text(size = 12), 
    legend.position = 'none'
  )


# combo and save ----------------------------------------------------------

combo = plot2 + plot1

ggsave('Tidy_Tues_plot.jpeg', 
       path = '~/GitHub/TidyTuesday/Pudding_data/', 
       plot = combo, 
       dpi = 'retina', 
       units = 'cm', 
       width = 25, 
       height = 16)
