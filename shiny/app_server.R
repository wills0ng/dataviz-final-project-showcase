library("dplyr")
library("plotly")
library("shiny")

source("age_and_gender.R")
source("time_day.R")
source("map.R")

get_app_server <- function(df) {
  server <- function(input, output) {
    output$age_and_gender <- renderPlotly({
      return(hist(
        df,
        input$group,
        input$select,
        input$gender,
        input$race,
        input$male_color,
        input$female_color,
        input$other_color
      ))
    })
    output$time_and_day <- renderPlotly({
      return(build_histogram(
        df,
        input$graph,
        input$time_selection,
        input$day_selection
      ))
    })
    output$collisions_map <- renderLeaflet({
      return(target_map(df, input$day, input$time))
    })
  }
  return(server)
}
