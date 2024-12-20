# Loading libraries
library(tidyverse)
library(lubridate)

# Reading data 
tyler_activity_final <- "https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv"

t_a_f <- read_csv(tyler_activity_final)

##getting a glimpse of the data

str(t_a_f)

head(t_a_f)

tail(t_a_f)

# Removing non-running activities 

running_t_a_f <- t_a_f %>% 
  filter(sport == "running")

#confirming filter
running_t_a_f

#focusing on normal running

norm_run_t_a_f <- running_t_a_f %>%
  filter(minutes_per_mile >= 5, minutes_per_mile <= 10, total_elapsed_time_s > 60)

#checking the above filtered data
norm_run_t_a_f

tail(norm_run_t_a_f)

# Converting timestamp and using case_when to create condition for defining different periods

period_t_a_f <- norm_run_t_a_f %>%
  mutate(timestamp = ymd_hms(timestamp),
         time_period = case_when(year < 2024 ~ "Pre-2024",
    year == 2024 & month(timestamp) >= 1 & month(timestamp) <= 6 ~ "Rehab (Jan-Jun 2024)",
    year == 2024 & month(timestamp) >= 7 ~ "Post-Rehab (Jul 2024 onwards)"
  ))

#confirming the added time_period column in the dataframe

period_t_a_f

str(period_t_a_f)

#grouping by new column
grouped_t_a_f <- period_t_a_f %>%
  group_by(time_period)


grouped_t_a_f

#creating a speed column by getting inverse of minutes_per_mile column
plot_t_a_f <- grouped_t_a_f %>%
  mutate(speed = 1 / minutes_per_mile)

plot_t_a_f # confirming speed column is created

# Plotting of SPM vs Speed by lap
## adding trend lines for each time period
ggplot(plot_t_a_f, aes(x = speed, y = steps_per_minute, color = time_period)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "lm", aes(group = time_period), linetype = "solid") +
  labs(title = "SPM vs Speed by Lap", x = "Speed", y = "SPM (Steps per Minute)") +
  theme_minimal() +
  theme(
    legend.position = "top",
    plot.title = element_text(hjust = 0.5),
    panel.grid.minor = element_blank(),
    axis.text = element_text(size = 11),
    axis.title = element_text(size = 11)
  )


# Post Rehab data after July 1, 2024 and converting timestamp to POSIXct

rehab_t_a_f <- plot_t_a_f %>% 
  mutate(timestamp = as.POSIXct(timestamp),
         date = as.Date(timestamp)) %>%
  filter(date > as.Date("2024-07-01"))

# Introducing lap number, ranking the laps within each run and selecting only the first 3 laps
ranked_rehab_t_a_f <- rehab_t_a_f %>%
  group_by(date) %>%
  mutate(lap_number = rank(timestamp)) %>%
  filter(lap_number <= 3)

ranked_rehab_t_a_f

head(ranked_rehab_t_a_f)

#confirming lap numbers are assigned

ranked_rehab_t_a_f $lap_number

# Plotting SPM vs Speed from the above data frame

ggplot(ranked_rehab_t_a_f, aes(x = lap_number, y = steps_per_minute)) +
  geom_point(aes(color = speed, size = speed), alpha = 0.3) + 
  scale_color_viridis_c() +
  labs(title = "SPM vs Speed for First 3 Laps (Post-Rehab)", 
       x = "Lap_Number", y = "Steps per Minute") +
  theme_minimal() +
  theme(
    legend.position = "top",
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(size = 11),
    axis.title = element_text(size = 11)
  )
