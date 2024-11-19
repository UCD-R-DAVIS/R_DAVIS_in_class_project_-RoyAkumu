#loading tidyverse library

library(tidyverse) 

#reading csv dataframe .csv file 

surveys <- read_csv("data/portal_data_joined.csv")

#Question 1

#going step by step before piping

# group by genus and plot type
group_by(surveys, genus, plot_type)

#removing na's from hindfoot_length
filter(surveys, !is.na(hindfoot_length))

#summarize with mean(hindfoot_length)
summarise(surveys, mean_hindfoot_length = mean(hindfoot_length)) #breaks at this point for some reason

#pivot wider
pivot_wider(surveys, names_from = plot_type, values_from = mean_hindfoot_length)

#introducing pipe function
surveys_wide <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(genus, plot_type) %>% 
  summarise(mean_hindfoot_length = mean(hindfoot_length)) %>% 
  pivot_wider(names_from = plot_type, values_from = mean_hindfoot_length)
  

surveys_wide


#sorting output by Control column
surveys_wide <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(genus, plot_type) %>% 
  summarise(mean_hindfoot_length = mean(hindfoot_length)) %>% 
  pivot_wider(names_from = plot_type, values_from = mean_hindfoot_length) %>% 
  arrange(Control)
 

surveys_wide

str(surveys_wide)


#Question 2

# defining rodent weight into 3 i.e. small, medium, large

summary(surveys$weight)
#hence 1st quartile is 20, 3rd quartile 48,

# create a new column for weight category using ##mutate function but adding the conditions to be satisfied

##case_when option
surveys_case_when <- surveys %>% 
  mutate(weight_cat = case_when(
    weight <= 20.00 ~ "small",
    weight > 20.00 & weight < 48.00 ~ "medium",
    weight >= 48.00 ~ "large"
  ))



surveys_case_when




##ifelse option
surveys_ifelse <- surveys %>% 
  mutate(weight_cat = ifelse(weight <= 20.00,"small",
                             ifelse(weight > 20.00 & weight < 48.00, "medium", "large")))


surveys_ifelse


#soft coding the 1st and 3rd quartile into the conditional statements

#unsure - to check asap!
    