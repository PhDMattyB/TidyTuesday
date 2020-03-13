##############################
## Tidy tuesday tuition data
##
## Matt Brachmann (PhDMattyB)
##
## 2020-03-13
##
##############################
dir.create('~/PhD/GitHub/TidyTuesday/College_tuition')

setwd('~/PhD/GitHub/TidyTuesday/College_tuition/')

library(patchwork)
library(janitor)
library(devtools)
library(skimr)
library(rsed)
library(data.table)
library(sjPlot)
library(tidyverse)

theme_set(theme_bw())

## Read in the data

tuition_cost = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/tuition_cost.csv')

tuition_income = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/tuition_income.csv') 

salary_potential = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/salary_potential.csv') %>% 
  rename(state = state_name)

historical_tuition = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/historical_tuition.csv')

diversity_school = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/diversity_school.csv')


Tuition_diversity = left_join(tuition_cost, 
                               diversity_school, 
                               by = c('name', 'state'))

large_data = left_join(Tuition_diversity, 
                 salary_potential, 
                 by = c('name', 'state'))
