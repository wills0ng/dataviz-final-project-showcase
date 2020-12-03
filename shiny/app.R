library("shiny")
  

# Source UI and server files
source("app_ui.R")
source("app_server.R")

# Load dataframe
collisions <- read.csv("latraffic2019-collisions.csv",
                       stringsAsFactors = FALSE)

# Get App UI and Server
ui <- get_app_ui(collisions)
server <- get_app_server(collisions)

# Start Shiny server
shinyApp(ui = ui, server = server)
