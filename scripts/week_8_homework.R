#Use the README file associated with the Mauna Loa dataset to determine in what time zone the data are reported, and how missing values are reported in each column. 
##With the mloa data.frame, remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s. 
###Generate a column called “datetime” using the year, month, day, hour24, and min columns. 
####Next, create a column called “datetimeLocal” that converts the datetime column to Pacific/Honolulu time (HINT: look at the lubridate function called with_tz()). Then, use dplyr to calculate the mean hourly temperature each month using the temp_C_2m column and the datetimeLocal columns. (HINT: Look at the lubridate functions called month() and hour()). 
#####Finally, make a ggplot scatterplot of the mean monthly temperature, with points colored by local hour.

#Loading libraries

library(tidyverse)

library(lubridate)


#Reading dataset

mloa <- read_csv("https://raw.githubusercontent.com/ucd-r-davis/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

?paste0

mloa_local = mloa %>%
  filter(rel_humid != -99) %>%
  filter(temp_C_2m != -999.9) %>%
  filter(windSpeed_m_s != -999.9) %>%   # Remove NA's using filter
  mutate(datetime = ymd_hm(paste0(year,"-", 
                                  month, "-", 
                                  day," ", 
                                  hour24, ":", 
                                  min), # adding datetime column
                           tz = "UTC")) %>% #converting timezone to UTC
  mutate(datetimeLocal = with_tz(datetime, tz = "Pacific/Honolulu")) #new column with local time

#looking at new dataframe

str(mloa_local)

head(mloa_local)


?with_tz #with_tz returns a date-time as it would appear in a different time zone

mloa_local %>%
  mutate(localMonth = month(datetimeLocal, label = TRUE),
         localHour = hour(datetimeLocal)) %>%
  group_by(localMonth, localHour) %>%
  summarize(meantemp = mean(temp_C_2m)) %>%
  ggplot(aes(x = localMonth,
             y = meantemp)) +
  geom_point(aes(colour = localHour)) +
  scale_color_viridis_c() +
  xlab("Month") +
  ylab("Mean temperature (degrees C)") +
  theme_classic()
