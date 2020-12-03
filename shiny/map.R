library(dplyr)
library(tidyr)
library(leaflet)

target_map <- function(df, day, time) {

  # Filter for selected time of day and day of week
  df_filtered <- df %>%
    mutate(day_of_week = weekdays(as.Date(Date.Occurred, format = "%m/%d/%Y")),
           time_of_day = case_when(
             Time.Occurred >= 500 & Time.Occurred <= 1159 ~ "Morning",
             Time.Occurred >= 1200 & Time.Occurred <= 1659 ~ "Afternoon",
             Time.Occurred >= 1700 & Time.Occurred <= 2059 ~ "Evening",
             (Time.Occurred >= 2100 & Time.Occurred <= 2400) |
               (Time.Occurred >= 1 & Time.Occurred <= 459) ~ "Night"
           )
    )

  # Create variable to filter for all collisions either by day or by time
  day_sel <- if (day == "All") unique(df_filtered$day_of_week) else day
  time_sel <- if (time == "All") unique(df_filtered$time_of_day) else time

  # Update filtered traffic collision data
  df_filtered <- df_filtered %>%
    filter(day_of_week %in% day_sel, time_of_day %in% time_sel)

  # Create summary of collisions per area name
  area_summary <- df_filtered %>%
    separate(Location, c("lat", "long"), ", ") %>%
    mutate(
      lat = as.numeric(gsub("\\(", "", lat)),
      long = as.numeric(gsub("\\)", "", long)),
    ) %>%
    group_by(Area.Name) %>%
    summarize(num_collisions = n(),
              lat = mean(lat),
              long = mean(long))

  # Define color pallete for LA area regions
  palette_fn <- colorFactor("Spectral", area_summary$Area.Name)

  # Function used to calculate radius for circle markers in map
  normalize <- function(x, a, b) {
    min <- min(x)
    max <- max(x)
    return((b - a) * ((x - min) / (max - min)) + a)
  }

  # Plot map, with markers for each area in LA.
  # Size varies by number of traffic collisions
  leaflet(data = area_summary) %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(lng = -118.249999, lat = 34.0499998, zoom = 10) %>%
    addCircleMarkers(
      lng = ~long,
      lat = ~lat,
      popup = ~paste("Area Name: ", Area.Name,
                     "<br>",
                     "Number of Collisions: ", num_collisions),
      radius = ~normalize(num_collisions, 1, 50),
      color = ~palette_fn(Area.Name)
    ) %>%
    addLegend(
      position = "bottomright",
      title = "Traffic Collisions by Area",
      pal = palette_fn,
      values = ~Area.Name,
      opacity = 1
    )
}
