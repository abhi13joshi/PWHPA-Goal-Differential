library(tidyverse)
library(dplyr)
library(ggplot2)
setwd('C:/Users/abhi1/OneDrive/Documents/NCSUSAC')

data <- read_csv("Clean PWHPA Secret Dream Gap Tour - Sportlogiq - PWHPA Secret Dream Gap Tour.csv")
colors <- read_csv("PWHPA Team Colors.csv")
view(data)
view(colors)
hockey_data <- data %>% group_by(team, gameid, goals_for, goals_against, result) %>% tally() %>% filter()
view(hockey_data)

goal_diff <- hockey_data %>% 
              group_by(team) %>% 
              summarize(gf=sum(goals_for), 
              ga=sum(goals_against)) %>% 
    ungroup() %>% 
  mutate(gd=gf-ga)
view(goal_diff)

plot<-ggplot(goal_diff, aes(x=gd, y=team, label=team)) + 
  geom_bar(stat='identity', color = 'navy', fill = c('#ee0b19', '#0a0f30', '#32364f', '#141517', '#6dd5e1'))  + 
  labs(title="Goal Differential for PWHPA 2021 season", 
       caption = 'Data Viz by Abhi Joshi & Pat Walther | Data from PWHPA and Sportlogiq',
       y='Team', x='Goal Differential') 
#+   coord_flip()
plot

#ggsave(filename = 'Goal Differential PWHPA 2021 Diverging Bar Chart.png', plot = plot)
