# Midpoint Deliverable Chart 3: Day of the week + time of the day

# Libraries
library("dplyr")
library("ggplot2")
library("plotly")
library("lintr")
library("knitr")
library("tidyr")
library("leaflet")
library("lintr")
library("styler")

# 2019 Dataframe
traffic_collisions_df_2019 <- read.csv("data/latraffic2019-accidents.csv",
  stringsAsFactors = FALSE
)

# Date conversion
dates <- as.Date(traffic_collisions_df_2019$Date.Occurred, format = "%m/%d/%Y")

# Creating a data frame for days of the week
traffic_plot_df <- traffic_collisions_df_2019 %>%
  mutate(day = weekdays(as.Date(dates))) %>%
  mutate(period = ifelse(Time.Occurred >= 500 &
    Time.Occurred <= 1159,
  "Morning",
  ifelse(Time.Occurred >= 1200 &
    Time.Occurred <= 1659,
  "Afternoon",
  ifelse(Time.Occurred >= 1700 &
    Time.Occurred <= 2059,
  "Evening",
  ifelse((Time.Occurred >= 2100 &
    Time.Occurred <= 2400) |
    (Time.Occurred >= 1 &
      Time.Occurred <= 459),
  "Night",
  ifelse(!(Time.Occurred >= 1 &
    Time.Occurred <= 2359),
  "Other", NA
  )
  )
  )
  )
  ))

# Arranging the plot
traffic_plot_df$day <- factor(traffic_plot_df$day,
  levels = c(
    "Sunday",
    "Saturday",
    "Friday",
    "Thursday",
    "Wednesday",
    "Tuesday",
    "Monday"
  )
)

# Barplot to visualize the data
time_of_day <- ggplot(traffic_plot_df, aes(x = day, fill = period)) +
  geom_histogram(aes(fill = period),
    stat = "count",
    col = "black"
  ) +
  geom_text(
    stat = "count", aes(
      label = ..count..,
      group = period
    ),
    position = position_stack(vjust = 0.5)
  ) +
  ylim(0, 10000) +
  labs(
    fill = "Time of the day",
    title = "Number of Accidents by Day of the Week + Time of the day",
    x = "Day", y = "Accidents"
  ) +
  coord_flip()
