library(dplyr)
library(tidyverse)
library(ggplot2)

# dataframe for LA
dataframe <- read.csv("data/latraffic2019-accidents.csv",
  stringsAsFactors = FALSE
)

# Filtering the data for the plot.
la_df <- dataframe %>%
  filter(is.na(Victim.Age) == FALSE) %>%
  mutate(count = 1) %>%
  mutate(gender = ifelse(Victim.Sex == "M" | Victim.Sex == "F", Victim.Sex,
    ifelse(!(Victim.Sex == "M" | Victim.Sex == "F"),
      "Other", NA
    )
  )) %>%
  mutate(age_group = ifelse(Victim.Age >= 18 & Victim.Age <= 24, "18-24",
    ifelse(Victim.Age >= 25 & Victim.Age <= 35, "25-35",
      ifelse(Victim.Age >= 36 & Victim.Age <= 55, "36-55",
        ifelse(Victim.Age > 55, "55+", NA)
      )
    )
  ))

# Plot for Demographics for Victims by Age Group and Gender
age_group_gender <- ggplot(data = subset(la_df, !is.na(age_group)), aes(x = age_group)) +
  geom_bar(aes(fill = gender)) +
  geom_text(
    stat = "count", aes(label = ..count.., group = gender),
    position = position_stack(vjust = 0.5)
  ) +
  xlab("Victim Age") +
  ylab("Number of Victims") +
  ggtitle("Demographics for Victims by Age Group and Gender")
