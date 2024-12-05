
#Load Tidyverse

library(tidyverse)

#Read data

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

head(gapminder)

tail(gapminder)

str(gapminder)

#1: Calculate the mean life expectancy on each continent.
##Group data by continent, year and summarize mean_lifeExp

group_by(gapminder, continent, year)

summarize(gapminder, mean_lifeExp = mean(lifeExp))


##Create a plot that shows how life expectancy has changed over time in each continent. 
###Use pipes to combine code
###geom point gives the scatter points
###geom line gives a line through the points above

gapminder %>%
  group_by(continent, year) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>%
  ggplot()+
  geom_point(aes(x = year, y = mean_lifeExp, color = continent))+
  geom_line(aes(x = year, y = mean_lifeExp, color = continent))



#2: Look at the following code and answer the following questions. What do you think the scale_x_log10() line of code is achieving? What about the geom_smooth() line of code?

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

#Question: What do you think the scale_x_log10() line of code is achieving? What about the geom_smooth() line of code?

?geom_smooth()

##Answer:  scale_x_log10() - - - without it, there is no spread along the x axis hence difficult to read changes across gdpPercap so basically improves the scale for readability/visualization
          #geom_smooth() - - - creates a line of best fit



#Challenge: Modify the above code to size the points in proportion to the population of the country. Hint: Are you translating data to a visual feature of the plot?

#Answer, change the size argument specified from a number to actual size of the population

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()



#3: Create a boxplot that shows the life expectancy for Brazil, China, El Salvador, Niger, and the United States, with the data points in the background using geom_jitter. Label the X and Y axis with “Country” and “Life Expectancy” and title the plot “Life Expectancy of Five Countries”.

#use filter to select required countries

#use ggtitle() to name the graph
?ggtitle

#use xlab() and ylab() to change x, y labels

countries <- c("Brazil", "China", "El Salvador", "Niger", "United States") 

gapminder %>% 
  filter(country %in% countries) %>% 
  ggplot(aes(x = country, y = lifeExp))+
  geom_boxplot() +
  geom_jitter()+
  ggtitle("Life Expectancy of Five Countries") + 
  xlab("Country") + ylab("Life Expectancy")


gapminder %>% 
  filter(gapminder) %>% 
  ggplot(aes(x = country, y = lifeExp))+
  geom_boxplot() +
  geom_jitter()+
  ggtitle("Life Expectancy of Five Countries") + 
  xlab("Country") + ylab("Life Expectancy")




























