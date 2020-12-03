calculate_mode <- function(x) {
  uniqx <- unique(na.omit(x))
  uniqx[which.max(tabulate(match(x, uniqx)))]
}

total_accidents <- nrow(latraffic) 

summary_df <- latraffic %>%
  group_by(Area.Name) %>% 
  summarize(
    num_of_accidents = n(),
    most_frequent_victim_desecent = calculate_mode(Victim.Descent),
    average_victim_age = round(mean(Victim.Age, na.rm = TRUE),2),
    accident_occur_percentage = round(num_of_accidents / total_accidents, 2))
