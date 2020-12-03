library(dplyr)

get_summary_information <- function(df) {
  ret <- list()
  
  ret$num_collisions <- nrow(df)
  
  ret$avg_weekly_collisions <- round(ret$num_collisions / 52)
  
  ret$highest_dow <- df %>%
    mutate(DOW.Occurred = weekdays(as.Date(Date.Occurred, "%m/%d/%Y"))) %>%
    count(DOW.Occurred) %>%
    arrange(desc(n)) %>%
    head(1) %>%
    pull(DOW.Occurred)
  
  ret$lowest_dow <- df %>%
    mutate(DOW.Occurred = weekdays(as.Date(Date.Occurred, "%m/%d/%Y"))) %>%
    count(DOW.Occurred) %>%
    arrange((n)) %>%
    head(1) %>%
    pull(DOW.Occurred)
  
  ret$highest_area_name <- df %>%
    count(Area.Name) %>%
    arrange(desc(n)) %>%
    head(1) %>%
    pull(Area.Name)
   return (ret)
}
