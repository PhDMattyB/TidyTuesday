##############################
## San Fran trees tidy tues
##
## Matt Brachmann (PhDMattyB)
##
## 2020-03-26
##
##############################
dir.create('~/PhD/GitHub/TidyTuesday/SFTrees')

setwd('~/PhD/GitHub/TidyTuesday/SFTrees/')

library(patchwork)
library(janitor)
library(tidyverse)

data = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-28/sf_trees.csv') 

clean = data %>% 
  select(-dbh, -plot_size) %>% 
  na.omit

View(clean)

