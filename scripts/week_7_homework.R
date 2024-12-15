#To get the population difference between 2002 and 2007 for each country, it would probably be easiest to have a country in each row and a column for 2002 population and a column for 2007 population.

#Notice the order of countries within each facet. You’ll have to look up how to order them in this way.

#Also look at how the axes are different for each facet. Try looking through ?facet_wrap to see if you can figure this one out.

#The color scale is different from the default- feel free to try out other color scales, just don’t use the defaults!
  
#The theme here is different from the default in a few ways, again, feel free to play around with other non-default themes.

#The axis labels are rotated! Here’s a hint: angle = 45, hjust = 1. It’s up to you (and Google) to figure out where this code goes!
  
#Is there a legend on this plot?

library(tidyverse)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

str(gapminder)

head(gapminder)

change_in_popn <- gapminder %>% 
  select(country, year, pop, continent) %>% 
  filter(year > 2000) %>% 
  pivot_wider(names_from = year, values_from = pop) %>% #Each unique year becomes a separate column, and the population values are spread across these columns.
  mutate(popn_change_2002_to_2007 = `2007` - `2002`) # new column with population change

change_in_popn

head(change_in_popn)

change_in_popn %>% 
  filter(continent != "Oceania") %>% 
  ggplot(aes(x = reorder(country, popn_change_2002_to_2007), y = popn_change_2002_to_2007)) +
  geom_col(aes(fill = continent)) +
  facet_wrap(~continent, scales = "free") + #plots each continent on its own space and the scales part replicates the same axes for each plot
  theme_bw() +
  scale_fill_viridis_d(direction = -1, alpha = 0.5) + #change in direction of the color scale
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
        legend.position = "none") +
  xlab("Country") +
  ylab("Change in Population Between 2002 and 2007")
