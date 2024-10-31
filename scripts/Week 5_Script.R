library(tidyverse)
surveys <- read.csv("data/portal_data_joined.csv")


#if else
#from base R
#Ifelse (test , what to do if yes/true, what ti do if no/false)
#missing values in test
##ifelse() strips attributes

surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length < mean(surveys$hindfoot_length, na.rm = TRUE), yes = "small", no = "big")

head(surveys$hindfoot_cat)
head(surveys$hindfoot_length)
summary(surveys$hindfoot_length)
surveys$record_id
unique(surveys$hindfoot_cat)


## case_when() ----
# GREAT help file with examples!
#from tidyverse so have to use within mutate()
## each case evaluated sequentially & first match determines corresponding value in the output vector
#case_when() equivalent of what we wrote in the ifelse function

?case_when

surveys %>% mutate(hindfoot_cat = case_when(hindfoot_length > 29.29 ~ "big",
                                   TRUE ~ "small")) %>%  select(hindfoot_length, hindfoot_cat) %>% head()

# hindfoot_length over mean 29.29, I want to be reclassified as "big"

table(surveys$hindfoot_cat)

test_2 <- surveys %>%  mutate(hindfoot_cat = case_when(hindfoot_length > 31.5 ~ "big", hindfoot_length > 29 ~ "medium", is.na(hindfoot_length) ~ NA_character_, TRUE ~ "small")) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head(100)

view(test_2)

## join ----
library(tidyverse)

tail <- read.csv('data/tail_length.csv')

surveys <- read.csv('data/portal_data_joined')

dim(tail)

dim(surveys)

head(tail)


#interjoin

surveys_inner <- inner_join(x = surveys, y = tail)

dim(surveys_inner)

head(surveys_inner)

all(surveys$record_id %in% tail$record_id)

all(tail$record_id %in% surveys$record_id)

#left_join

surveys_left <- left_join(x = surveys, y = tail)

dim(surveys_left)

table(is.na(surveys_left$tail_length))


#right_join

surveys_right <- right_join()


#full join

surveys_full <- full_join(x = surveys, y = tail)

#challenge



#pivot
surveys_mz <- surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))

surveys_mz

surveys_mz %>%  pivot_wider(id_cols = 'genus',
                            names_from = plot_id,
                            values_from = 'mean_weight')
