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

