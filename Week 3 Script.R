# Other data types
## Lists --- multiple vectors

c(4, 6, "dog")
a <- list(4, 6, "dog")

class(a)

str(a)

#Data.frames
letters

data.frame(letters)

df <- data.frame(letters)

length(df)

dim(df)

nrow(df)

ncol(df)

# Matrices = 2 dimensional

#Arrays = 3 dimensional


#Factors = character values with some sort of order

animals <- factor(c("duck", "duck", "goose", "goose"))


animals

animals <- factor(c("pigs", "duck","duck","goose","goose"))

animals

class(animals)

levels(animals)

nlevels(animals)

animals <- factor(x = animals, levels = c("goose", "pigs", "duck"))

animals
animals <- factor(x = animals, levels = c("goose", "pigs", "duck")

                  
                  
animals
year <- factor(c(1978, 1980, 1934, 1979))


as.numeric(animals)

as.character(animals)

?factor

?read.csv


surveys <- read.csv("data/portal_data_joined.csv")

surveys

str(surveys)

nrow(surveys)

ncol(surveys)

dim(surveys)

class((surveys))

summary(surveys)

?summary

summary.data.frame(surveys)

#indexing row 1, column 5
surveys[1,5]


surveys[c(1,5,24,3001),]

surveys[1:5,]

surveys[,1]

surveys[1,]

dim(surveys[,1:5])

colnames(surveys)

surveys[c('record_id', 'year', 'day')]

cols_to_grab = c('record_id', 'year', 'day')
cols_to_grab
surveys[cols_to_grab]

head(surveys)

dim(surveys)

dim(surveys)

head(surveys)

surveys[1:6,]

head(surveys["genus"])

head(surveys[["genus"]])

str(surveys)

head(surveys[c("genus", "species")])

# dollar sign to open up
surveys$hindfoot_length

class(surveys$hindfoot_length)


surveys$plot_id

class(surveys$hindfoot_length)

##tidyverse
install.packages("tidyverse")

library(tidyverse)

?read_csv

t_surveys <- read_csv('data/portal_data_joined.csv')

class(t_surveys)

t_surveys
