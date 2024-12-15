#Loading surveys data set

surveys <- read.csv("data/portal_data_joined.csv")

#Loading Mauna Loa dataset

mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

str(mloa)

#loading libraries

library(tidyverse)
library(lubridate)

#1. Using a for loop, print to the console the longest species name of each taxon. Hint: the function nchar() gets you the number of characters in a string.

#details for nchar and paste0()
?nchar

?paste0

for(i in unique(surveys$taxa)){
  mytaxon <- surveys[surveys$taxa == i,]
  longestnames <- mytaxon[nchar(mytaxon$species) == max(nchar(mytaxon$species)),] %>% select(species)
  print(paste0("The longest species name(s) among ", i, "s is/are: "))
  print(unique(longestnames$species))
}

#2. Use the map function from purrr to print the max of specified columns:


column_max <- mloa %>% 
  select("windDir","windSpeed_m_s","baro_hPa","temp_C_2m","temp_C_10m","temp_C_towertop","rel_humid", "precip_intens_mm_hr") %>% 
  map(max,na.rm = T ) 

column_max

#3. Make a function called C_to_F that converts Celsius to Fahrenheit. 
C_to_F <- function(x){
  x * (9/5) + 32
}
##Make three new columns called “temp_F_2m”, “temp_F_10m”, and “temp_F_towertop” by applying this function to columns “temp_C_2m”, “temp_C_10m”, and “temp_C_towertop”. 

mloa$temp_F_2m <- C_to_F(mloa$temp_C_2m)
mloa$temp_F_10m <- C_to_F(mloa$temp_C_10m)
mloa$temp_F_towertop <- C_to_F(mloa$temp_C_towertop)

#Trying map_df? function (Looked up the answers for this one :)
mloa %>% select(c("temp_C_2m", "temp_C_10m", "temp_C_towertop")) %>% map_df(C_to_F) %>% rename("temp_F_2m"="temp_C_2m", "temp_F_10m"="temp_C_10m", "temp_F_towertop"="temp_C_towertop") %>% cbind(mloa)



#In class Revision

#challenge: use lapply to create a new column of the surveys dataframe that includes the genus and species name together as one string

surveys$genusspecies <- lapply(1:length(surveys$species), function(i){
  paste0(surveys$genus[i], " ", surveys$species[i])
})
