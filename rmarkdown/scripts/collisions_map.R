library(dplyr)
library(tidyr)
library(ggplot2)
library(leaflet)

# Los Angeles Traffic report for only Area, MO codes, Street Address, and
# location
la_traffic_report <-
  read.csv("data/latraffic2019-accidents.csv", stringsAsFactors = FALSE) %>%
  group_by(Area.Name) %>%
  separate(Location, c("lat", "long"), ", ") %>%
  mutate(
    lat = as.numeric(gsub("\\(", "", lat)),
    long = as.numeric(gsub("\\)", "", long)),
  ) %>%
  select(Area.Name, Address, Victim.Sex, Victim.Descent, long, lat) %>%
  filter(Victim.Descent == "W")

# Convert data into dataframe
la_df <- data.frame(la_traffic_report)

# Create pallette function for mapping colors by area
palette_fn <- colorFactor(topo.colors(21), domain = la_df$Area.Name)

# Plot map, with markers for each traffic collision
la_map <- leaflet(la_df) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -118.249999, lat = 34.0499998, zoom = 10) %>%
  addCircleMarkers(
    lng = ~long,
    lat = ~lat,
    popup = ~paste("Area Name: ", Area.Name, "<br>", "Street Address: ",
                   Address, "<br>", "Victim Sex: ", Victim.Sex),
    radius = 5,
    stroke = FALSE,
    color = ~palette_fn(Area.Name),
    fillOpacity = 0.1
  ) %>%
  addLegend(
    position = "bottomright",
    title = "Traffic Collisions in Los Angeles by Area",
    pal = palette_fn,
    values = ~Area.Name,
    opacity = 1
  )
