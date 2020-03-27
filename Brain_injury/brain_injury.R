##############################
## Brain injury graphics tidy tues
##
## Matt Brachmann (PhDMattyB)
##
## 2020-03-26
##
##############################
dir.create('~/PhD/GitHub/TidyTuesday/Brain_injury')

setwd('~/PhD/GitHub/TidyTuesday/Brain_injury/')

library(patchwork)
# library(tidytuesdayR)
library(tidyverse)


# data --------------------------------------------------------------------
age = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_age.csv')
year = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_year.csv')
military = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_military.csv')

year %>% 
  mutate(type = ifelse(str_detect(type, 'Emer'), 
                       'ER visits', type),
         type = factor(type, levels = c('ER visits',
                                        'Hospitalizations',
                                        'Deaths'))) %>% 
  group_by(type)
