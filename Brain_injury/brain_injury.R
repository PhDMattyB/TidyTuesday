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

test = left_join(age, 
                 year, 
                 by = c('injury_mechanism', 
                                   'type',
                        'number_est',
                        'rate_est'))

test %>% 
  # group_by(age_group,
  #          type) %>% 
  ggplot(aes(x = injury_mechanism, 
         y = rate_est))+
  geom_boxplot()
  # geom_bar(aes(col = age_group,
  #              fill = age_group))
  # geom_violin(aes(col = age_group))
