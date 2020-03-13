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

## View a dataset
View(tuition_cost)
 
## create a data set for cost per state
state_cost = tuition_cost %>% 
  group_by(state) %>% 
  summarise(avg_in_tuition = mean(in_state_total),
            avg_out_tuition = mean(out_of_state_total))

## create a dataset for tuition cost and pay in career
cost_pay = left_join(tuition_cost, 
                     salary_potential, 
                     by = c('name', 
                            'state')) %>% 
  select(name, 
         state, 
         in_state_total, 
         out_of_state_total, 
         early_career_pay, 
         mid_career_pay, 
         type) %>% 
  na.omit()

