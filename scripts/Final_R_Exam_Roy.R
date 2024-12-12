# Load necessary libraries
library(tidyverse)
library(lubridate)

# Read the data from the URL
url <- "https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv"
data <- read_csv(url)

# Convert timestamp to Date
data <- data %>%
  mutate(timestamp = mdy_hms(timestamp),
         date = as.Date(timestamp))

# Filter out non-running activities:
# 1. Remove laps with pace > 10 minutes per mile (walking).
# 2. Remove laps with pace < 5 minutes per mile (too fast).
# 3. Remove laps with elapsed time <= 1 minute.

filtered_data <- data %>%
  filter(pace >= 5, pace <= 10, elapsed_time > 1)

# Group observations into three time periods:
filtered_data <- filtered_data %>%
  mutate(time_period = case_when(
    date < "2024-01-01" ~ "Pre-2024",
    date >= "2024-01-01" & date <= "2024-06-30" ~ "Rehab (Jan-Jun 2024)",
    date >= "2024-07-01" ~ "Post-Rehab (Jul 2024 onwards)"
  ))

# Scatter plot of SPM vs Speed by lap, with trend lines for each time period
ggplot(filtered_data, aes(x = speed, y = spm, color = time_period)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, aes(group = time_period), linetype = "solid") +
  labs(title = "SPM vs Speed by Lap", x = "Speed (miles per hour)", y = "SPM (Steps per Minute)") +
  theme_minimal() +
  theme(
    legend.position = "top",
    plot.title = element_text(hjust = 0.5),
    panel.grid.major = element_line(color = "lightgray", size = 0.5),
    panel.grid.minor = element_blank(),
    axis.text = element_text(size = 12),
    axis.title = element_text(size = 14)
  )

# Analysis for post-intervention (after July 1, 2024)
post_rehab_data <- filtered_data %>%
  filter(date >= "2024-07-01")

# Rank laps within each run (assuming all laps on a given day correspond to the same run)
post_rehab_data <- post_rehab_data %>%
  group_by(date) %>%
  mutate(lap_number = rank(timestamp)) %>%
  filter(lap_number <= 3)  # Select only the first 3 laps

# Plot SPM vs Speed for first 3 laps post-rehab
ggplot(post_rehab_data, aes(x = speed, y = spm, color = as.factor(lap_number))) +
  geom_point(alpha = 0.6) +
  labs(title = "SPM vs Speed for First 3 Laps (Post-Rehab)", 
       x = "Speed (miles per hour)", y = "SPM (Steps per Minute)", color = "Lap Number") +
  theme_minimal() +
  theme(
    legend.position = "top",
    plot.title = element_text(hjust = 0.5),
    panel.grid.major = element_line(color = "lightgray", size = 0.5),
    panel.grid.minor = element_blank(),
    axis.text = element_text(size = 12),
    axis.title = element_text(size = 14)
  )
