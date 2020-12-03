# Libraries
library("dplyr")
library("plotly")
library("stringr")
library("styler")
library("data.table")

# Histogram function
build_histogram <- function(traffic_plot, graphs, time_select, day_select) {
  traffic_summarize <- traffic_plot %>%
    mutate(day = weekdays(as.Date(Date.Occurred, format = "%m/%d/%Y"))) %>%
    mutate(Morning = ifelse(Time.Occurred >= 500 &
                              Time.Occurred <= 1159, 1, 0)) %>%
    mutate(Afternoon = ifelse(Time.Occurred >= 1200 &
                                Time.Occurred <= 1659, 1, 0)) %>%
    mutate(Evening = ifelse(Time.Occurred >= 1700 &
                              Time.Occurred <= 2059, 1, 0)) %>%
    mutate(Night = ifelse((Time.Occurred >= 2100 & Time.Occurred <= 2400) |
                            (Time.Occurred >= 1 & Time.Occurred <= 459),
                          1,
                          0
    )) %>%
    group_by(day) %>%
    summarize(
      Morning = sum(Morning),
      Afternoon = sum(Afternoon),
      Evening = sum(Evening),
      Night = sum(Night)
    )
  traffic_total <- traffic_plot %>%
    mutate(day = weekdays(as.Date(Date.Occurred, format = "%m/%d/%Y"))) %>%
    group_by(day) %>%
    summarize(total = n())
  traffic_flip <- as.data.frame(t(traffic_summarize)) %>%
    rename(
      Friday = V1,
      Monday = V2,
      Saturday = V3,
      Sunday = V4,
      Thursday = V5,
      Tuesday = V6,
      Wednesday = V7
    )
  traffic_delete <- traffic_flip[-c(0, 1), ]
  traffic_delete <- setDT(traffic_delete, keep.rownames = TRUE)[] %>%
    rename(period = rn)
  traffic_delete$period <- factor(traffic_delete$period, levels = c(
    "Morning",
    "Afternoon",
    "Evening",
    "Night"
  ))
  # Graph selection
  if (graphs == "Bar") {
    if (time_select == "total") {
      plot_ly(traffic_total) %>%
        add_trace(
          type = "bar",
          x = ~day,
          y = ~total,
          marker = list(
            color = c(
              "#0000FF",
              "#C0C0C0",
              "#C0C0C0",
              "#FF0000",
              "#C0C0C0",
              "#C0C0C0",
              "#C0C0C0"
            ),
            opacity = rep(0.8, 7)
          )
        ) %>%
        layout(
          xaxis = list(
            categoryorder = "array",
            categoryarray = c(
              "Sunday",
              "Monday",
              "Tuesday",
              "Wednesday",
              "Thursday",
              "Friday",
              "Saturday"
            ),
            title = "Weekdays"
          ),
          yaxis = list(title = "Accidents (in thousands)"),
          title = paste0("Accidents by Day of Week")
        )
    }
    else if (time_select == "Morning") {
      plot_ly(traffic_summarize) %>%
        add_trace(
          type = "bar",
          x = ~day,
          y = ~Morning,
          marker = list(
            color = c(
              "#C0C0C0",
              "#C0C0C0",
              "#C0C0C0",
              "#FF0000",
              "#C0C0C0",
              "#0000FF",
              "#C0C0C0"
            ),
            opacity = rep(0.8, 7)
          )
        ) %>%
        layout(
          xaxis = list(
            categoryorder = "array",
            categoryarray = c(
              "Sunday",
              "Monday",
              "Tuesday",
              "Wednesday",
              "Thursday",
              "Friday",
              "Saturday"
            ),
            title = "Weekdays"
          ),
          yaxis = list(title = "Accidents (in thousands)"),
          title = paste0("Accidents by Time and Day")
        )
    }
    else if (time_select == "Afternoon") {
      plot_ly(traffic_summarize) %>%
        add_trace(
          type = "bar",
          x = ~day,
          y = ~Afternoon,
          marker = list(
            color = c(
              "#0000FF",
              "#C0C0C0",
              "#C0C0C0",
              "#FF0000",
              "#C0C0C0",
              "#C0C0C0",
              "#C0C0C0"
            ),
            opacity = rep(0.8, 7)
          )
        ) %>%
        layout(
          xaxis = list(
            categoryorder = "array",
            categoryarray = c(
              "Sunday",
              "Monday",
              "Tuesday",
              "Wednesday",
              "Thursday",
              "Friday",
              "Saturday"
            ),
            title = "Weekdays"
          ),
          yaxis = list(title = "Accidents (in thousands)"),
          title = paste0("Accidents by Time and Day")
        )
    }
    else if (time_select == "Evening") {
      plot_ly(traffic_summarize) %>%
        add_trace(
          type = "bar",
          x = ~day,
          y = ~Evening,
          marker = list(
            color = c(
              "#0000FF",
              "#C0C0C0",
              "#C0C0C0",
              "#FF0000",
              "#C0C0C0",
              "#C0C0C0",
              "#C0C0C0"
            ),
            opacity = rep(0.8, 7)
          )
        ) %>%
        layout(
          xaxis = list(
            categoryorder = "array",
            categoryarray = c(
              "Sunday",
              "Monday",
              "Tuesday",
              "Wednesday",
              "Thursday",
              "Friday",
              "Saturday"
            ),
            title = "Weekdays"
          ),
          yaxis = list(title = "Accidents (in thousands)"),
          title = paste0("Accidents by Time and Day")
        )
    }
    else {
      plot_ly(traffic_summarize) %>%
        add_trace(
          type = "bar",
          x = ~day,
          y = ~Night,
          marker = list(
            color = c(
              "#C0C0C0",
              "#FF0000",
              "#0000FF",
              "#C0C0C0",
              "#C0C0C0",
              "#C0C0C0",
              "#C0C0C0"
            ),
            opacity = rep(0.8, 7)
          )
        ) %>%
        layout(
          xaxis = list(
            categoryorder = "array",
            categoryarray = c(
              "Sunday",
              "Monday",
              "Tuesday",
              "Wednesday",
              "Thursday",
              "Friday",
              "Saturday"
            ),
            title = "Weekdays"
          ),
          yaxis = list(title = "Accidents (in thousands)"),
          title = paste0("Accidents by Time and Day")
        )
    }
  }
  else {
    if (day_select == "Monday") {
      plot_ly(traffic_delete,
              x = ~period,
              y = ~Monday,
              type = "scatter",
              mode = "lines+markers",
              line = list(
                color = "blue",
                shape = "spline"
              ),
              width = 2
      ) %>%
        layout(
          title = "Accidents by Parts of the Day",
          xaxis = list(title = "Monday"),
          yaxis = list(title = "Number of Accidents")
        )
    }
    else if (day_select == "Tuesday") {
      plot_ly(traffic_delete,
              x = ~period,
              y = ~Tuesday,
              type = "scatter",
              mode = "lines+markers",
              line = list(
                color = "blue",
                shape = "spline"
              ),
              width = 2
      ) %>%
        layout(
          title = "Accidents by Parts of the Day",
          xaxis = list(title = "Tuesday"),
          yaxis = list(title = "Number of Accidents")
        )
    }
    else if (day_select == "Wednesday") {
      plot_ly(traffic_delete,
              x = ~period,
              y = ~Wednesday,
              type = "scatter",
              mode = "lines+markers",
              line = list(
                color = "blue",
                shape = "spline"
              ),
              width = 2
      ) %>%
        layout(
          title = "Accidents by Parts of the Day",
          xaxis = list(title = "Wednesday"),
          yaxis = list(title = "Number of Accidents")
        )
    }
    else if (day_select == "Thursday") {
      plot_ly(traffic_delete,
              x = ~period,
              y = ~Thursday,
              type = "scatter",
              mode = "lines+markers",
              line = list(
                color = "blue",
                shape = "spline"
              ),
              width = 2
      ) %>%
        layout(
          title = "Accidents by Parts of the Day",
          xaxis = list(title = "Thursday"),
          yaxis = list(title = "Number of Accidents")
        )
    }
    else if (day_select == "Friday") {
      plot_ly(traffic_delete,
              x = ~period,
              y = ~Friday,
              type = "scatter",
              mode = "lines+markers",
              line = list(
                color = "blue",
                shape = "spline"
              ),
              width = 2
      ) %>%
        layout(
          title = "Accidents by Parts of the Day",
          xaxis = list(title = "Friday"),
          yaxis = list(title = "Number of Accidents")
        )
    }
    else if (day_select == "Saturday") {
      plot_ly(traffic_delete,
              x = ~period,
              y = ~Saturday,
              type = "scatter",
              mode = "lines+markers",
              line = list(
                color = "blue",
                shape = "spline"
              ),
              width = 2
      ) %>%
        layout(
          title = "Accidents by Parts of the Day",
          xaxis = list(title = "Saturday"),
          yaxis = list(title = "Number of Accidents")
        )
    }
    else {
      plot_ly(traffic_delete,
              x = ~period,
              y = ~Sunday,
              type = "scatter",
              mode = "lines+markers",
              line = list(
                color = "blue",
                shape = "spline"
              ),
              width = 2
      ) %>%
        layout(
          title = "Accidents by Parts of the Day",
          xaxis = list(title = "Sunday"),
          yaxis = list(title = "Number of Accidents")
        )
    }
  }
}
