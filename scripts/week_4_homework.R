# Create a tibble named surveys from reading the csv file

library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv")

head(surveys)

# Subset surveys using tidyverse methods to keep rows with weight between 30 and 60 

surveys2 <- filter(surveys, weight >= 30 & weight<= 60)

surveys2

summary(surveys2)

# and print out the first 6 rows

head(surveys2)


# Create new tibble showing max weight for each species + sex combination


biggest_critters <- surveys %>% 
  filter(!is.na(sex)) %>% 
  filter(!is.na(weight)) %>% 
  group_by(species, sex) %>% 
  summarize(max_weight = max(weight, na.rm = T), min_weight = min(weight, na.rm = T)) %>% 
  arrange(max_weight)


biggest_critters

str(biggest_critters)

summary(biggest_critters)

# Sorting out where the most NA weights are concentrated
colSums(is.na(surveys))

colSums(is.na(biggest_critters)) #baseR function that checks NA counts in each column

?tally

tally(surveys) # counts all values

tally(surveys, is.na(surveys)) # counts all NAs in whole dataframe



# Remove rows with NA and add new column with avg. weight of each species  + sex combination to original surveys data frame

# Get rid of all columns except for species, sex, weight and new avg. weight column

surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(avg_weight = mean(weight)) %>% 
  select(species_id, sex, weight, avg_weight)


surveys_avg_weight

# Add new column "above average" with logical values stating whether/not a row's weight is above average for it's species + sex combination

surveys_avg_weight <- surveys_avg_weight %>% 
  mutate(above_average = weight > avg_weight)

surveys_avg_weight







