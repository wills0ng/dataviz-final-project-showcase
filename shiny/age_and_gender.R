library(shiny)
library(plotly)
library(dplyr)
# dataframe for LA
df <- read.csv("latraffic2019-collisions.csv",
               stringsAsFactors = FALSE
)
# Making the histogram
hist <- function(dataframe,
                 group,
                 select,
                 gender,
                 race,
                 male_color,
                 female_color,
                 other_color) {
  summary <- dataframe %>%
    mutate(age_group = ifelse(Victim.Age >= 18 & Victim.Age <= 27,
                              "18-27",
                              ifelse(Victim.Age >= 28 &
                                       Victim.Age <= 37,
                                     "28-37",
                                     ifelse(Victim.Age >= 38 &
                                              Victim.Age <= 47,
                                            "38-47",
                                            ifelse(Victim.Age >= 48 &
                                                     Victim.Age <= 57,
                                                   "48-58",
                                                   ifelse(Victim.Age > 58,
                                                          "58+", NA)))))) %>%
    mutate(male = ifelse(Victim.Sex == "M", 1, 0)) %>%
    mutate(female = ifelse(Victim.Sex == "F", 1, 0)) %>%
    mutate(other = ifelse(!(Victim.Sex == "M" | Victim.Sex == "F"), 1, 0)) %>%
    mutate(ethnicity = ifelse(Victim.Descent == "B", "Black",
                              ifelse(Victim.Descent == "W", "White",
                                     ifelse(Victim.Descent == "H", "Hispanics",
                                            ifelse((Victim.Descent == "A" |
                                                      Victim.Descent == "C" |
                                                      Victim.Descent == "D" |
                                                      Victim.Descent == "F" |
                                                      Victim.Descent == "J" |
                                                      Victim.Descent == "K" |
                                                      Victim.Descent == "L" |
                                                      Victim.Descent == "V" |
                                                      Victim.Descent == "Z"),
                                                   "Asian",
                                                   ifelse(Victim.Descent == "X",
                                                          "Unknown",
                                                          "Other")))))) %>%
    mutate(black = ifelse(Victim.Descent == "B", 1, 0)) %>%
    mutate(white = ifelse(Victim.Descent == "W", 1, 0)) %>%
    mutate(hispanics = ifelse(Victim.Descent == "H", 1, 0)) %>%
    mutate(asian = ifelse((Victim.Descent == "A" |
                             Victim.Descent == "C" |
                             Victim.Descent == "D" |
                             Victim.Descent == "F" |
                             Victim.Descent == "J" |
                             Victim.Descent == "K" |
                             Victim.Descent == "L" |
                             Victim.Descent == "V" |
                             Victim.Descent == "Z"), 1, 0)) %>%
    mutate(unknown = ifelse(Victim.Descent == "X", 1, 0)) %>%
    mutate(other_races = ifelse((Victim.Descent == "G" |
                                   Victim.Descent == "I" |
                                   Victim.Descent == "O" |
                                   Victim.Descent == "P" |
                                   Victim.Descent == "S" |
                                   Victim.Descent == "U"), 1, 0)) %>%
    group_by(age_group, ethnicity) %>%
    summarize(count = n(),
              male = sum(male),
              female = sum(female),
              other = sum(other),
              black = sum(black),
              white = sum(white),
              hispanics = sum(hispanics),
              asian = sum(asian),
              unknown = sum(unknown),
              other_races = sum(other_races))
  #Plot for All
  if (select == "Gender") {
    if (gender == "All") {
      plot <- plot_ly(summary) %>%
        add_bars(
          x = ~age_group,
          y = ~male,
          color = I("light blue"),
          width = 0.2,
          name = "Male"
        ) %>%
        add_bars(
          x = ~age_group,
          y = ~female,
          color = I("red"),
          width = 0.2,
          name = "Female"
        ) %>%
        add_bars(
          x = ~age_group,
          y = ~other,
          color = I("purple"),
          width = 0.2,
          name = "Other"
        ) %>%
        layout(
          xaxis = list(title = "Victim Age"),
          yaxis = list(title = "Number of Victims"),
          title = paste0("Demographics for Victims by Age Group and Gender"),
          legend = list(title = list(text = "<b> Gender </b>"))
        )
    }
    # Plot for Males and Females
    else if (gender == "Male and Female") {
      plot <- plot_ly(summary) %>%
        add_bars(
          x = ~age_group,
          y = ~male,
          color = I("light blue"),
          width = 0.2,
          name = "Male"
        ) %>%
        add_bars(
          x = ~age_group,
          y = ~female,
          color = I("red"),
          width = 0.2,
          name = "Female"
        ) %>%
        layout(
          xaxis = list(title = "Victim Age"),
          yaxis = list(title = "Number of Victims"),
          title = paste0("Demographics for Victims by Age Group (M/F)"),
          legend = list(title = list(text = "<b> Gender </b>")),
          showlegend = TRUE
        )
    }
    # Plot for Males and Others
    else if (gender == "Male and Other") {
      plot <- plot_ly(summary) %>%
        add_bars(
          x = ~age_group,
          y = ~male,
          color = I("light blue"),
          width = 0.2,
          name = "Male"
        ) %>%
        add_bars(
          x = ~age_group,
          y = ~other,
          color = I("purple"),
          width = 0.2,
          name = "Other"
        ) %>%
        layout(
          xaxis = list(title = "Victim Age"),
          yaxis = list(title = "Number of Victims"),
          title = paste0("Demographics for Victims by Age Group (M/O)"),
          legend = list(title = list(text = "<b> Gender </b>")),
          showlegend = TRUE
        )
    }
    #Plot for Female and Others
    else {
      plot <- plot_ly(summary) %>%
        add_bars(
          x = ~age_group,
          y = ~female,
          color = I("red"),
          width = 0.2,
          name = "Female"
        ) %>%
        add_bars(
          x = ~age_group,
          y = ~other,
          color = I("purple"),
          width = 0.2,
          name = "Other"
        ) %>%
        layout(
          xaxis = list(title = "Victim Age"),
          yaxis = list(title = "Number of Victims"),
          title = paste0("Demographics for Victims by Age Group (F/O)"),
          legend = list(title = list(text = "<b> Gender </b>")),
          showlegend = TRUE
        )
    }
  }
  #Plot for Races
  else {
    plot <- plot_ly(summary) %>%
      add_bars(
        x = ~age_group,
        y = ~black,
        color = I("red"),
        width = 0.1,
        name = "Black"
      ) %>%
      add_bars(
        x = ~age_group,
        y = ~white,
        color = I("forestgreen"),
        width = 0.1,
        name = "White"
      ) %>%
      add_bars(
        x = ~age_group,
        y = ~asian,
        color = I("blue"),
        width = 0.1,
        name = "Asian"
      ) %>%
      add_bars(
        x = ~age_group,
        y = ~hispanics,
        color = I("purple"),
        width = 0.1,
        name = "Hispanics"
      ) %>%
      add_bars(
        x = ~age_group,
        y = ~unknown,
        color = I("orange"),
        width = 0.1,
        name = "Unknown"
      ) %>%
      add_bars(
        x = ~age_group,
        y = ~other_races,
        color = I("pink"),
        width = 0.1,
        name = "Other"
      ) %>%
      layout(
        xaxis = list(title = "Victim Age"),
        yaxis = list(title = "Number of Victims"),
        title = paste0("Demographics for Victims by Age Group (Race)"),
        legend = list(title = list(text = "<b> Race </b>")),
        showlegend = TRUE
      )
  }
}
