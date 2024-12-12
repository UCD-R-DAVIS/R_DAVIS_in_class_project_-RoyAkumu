# Descriptive analysis on Tyler's running efforts ----
#Read in the Tylers activity laps file

library(tidyverse)

library(httr)

tyler_activity_laps <- read.csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv")

tyler_activity_laps

str(tyler_activity_laps)

head(tyler_activity_laps)

summary(tyler_activity_laps)

ncol(tyler_activity_laps)

nrow(tyler_activity_laps)

#filter out non running activities
filter(tyler_activity_laps, sport == "running")

#filter out walks (>10mins/mile) and filtering out abnormally fast laps (<5mins/mile)
filter(tyler_activity_laps, minutes_per_mile >= 5.00 & minutes_per_mile < 10)

tyler_activity_laps %>% 
  filter(total_elapsed_time_s > 60.00) %>% 
  filter(sport == "running") %>%
  filter(minutes_per_mile >= 5.00 & minutes_per_mile < 10) %>% 
  mutate(pace = case_when(minutes_per_mile < 6 ~ "fast",
                          minutes_per_mile >= 6 & minutes_per_mile <= 8 ~ "medium",
                          minutes_per_mile > 8 ~ "slow")) %>%
  mutate(form = case_when(year == 2024 ~ "new",
                                   year != 2024 ~ "old")) 

#select average steps per minute by form and pace
tyler_activity_laps %>% 
  filter(total_elapsed_time_s > 60.00) %>% 
  filter(sport == "running") %>%
  filter(minutes_per_mile >= 5.00 & minutes_per_mile < 10) %>% 
  mutate(pace = case_when(minutes_per_mile < 6 ~ "fast",
                          minutes_per_mile >= 6 & minutes_per_mile <= 8 ~ "medium",
                          minutes_per_mile > 8 ~ "slow")) %>%
  mutate(form = case_when(year == 2024 ~ "new",
                          year != 2024 ~ "old")) %>% 
  select(steps_per_minute, pace, form)

#pivoting wider with form as rows and pace as columns
tyler_activity_laps %>% 
  filter(total_elapsed_time_s > 60.00) %>% 
  filter(sport == "running") %>%
  filter(minutes_per_mile >= 5.00 & minutes_per_mile < 10) %>% 
  mutate(pace = case_when(minutes_per_mile < 6 ~ "fast",
                          minutes_per_mile >= 6 & minutes_per_mile <= 8 ~ "medium",
                          minutes_per_mile > 8 ~ "slow")) %>%
  mutate(form = case_when(year == 2024 ~ "new",
                          year != 2024 ~ "old")) %>% 
  select(steps_per_minute, pace, form) %>% 
  pivot_wider(names_from = "pace", values_from = "form")

#summary between January - June 2024 and July - October 2024
tyler_activity_laps %>% 
  filter(total_elapsed_time_s > 60.00) %>% 
  filter(sport == "running") %>%
  filter(minutes_per_mile >= 5.00 & minutes_per_mile < 10) %>% 
  mutate(pace = case_when(minutes_per_mile < 6 ~ "fast",
                          minutes_per_mile >= 6 & minutes_per_mile <= 8 ~ "medium",
                          minutes_per_mile > 8 ~ "slow")) %>%
  filter(year == 2024) %>% 
  select(month = 1:10) %>% 
  summarise(tyler_activity_laps, max(steps_per_minute), min(steps_per_minute), mean(steps_per_minute), median(steps_per_minute))



#review
tyler_activity_laps %>% 
  filter(total_elapsed_time_s > 60.00) %>% 
  filter(sport == "running") %>%
  filter(minutes_per_mile >= 5.00 & minutes_per_mile < 10) %>% 
  mutate(pace = case_when(minutes_per_mile < 6 ~ "fast",
                          minutes_per_mile >= 6 & minutes_per_mile <= 8 ~ "medium",
                          minutes_per_mile > 8 ~ "slow")) %>%
  mutate(form = ifelse(year == 2024, 'new', 'old')) %>% 
  group_by(pace, form) %>% 
  summarize(mean_steps = mean(steps_per_minute)) %>% 
  pivot_wider(id_cols = 'form', names_from = 'pace', values_from = 'mean_steps')
