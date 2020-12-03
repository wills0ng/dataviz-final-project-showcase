library(shinythemes)

get_app_ui <- function(df) {
  # Define title for the navbar
  project_title <- "LA Traffic Collisions"

  # Overview page
  overview <- tabPanel(
    title = "Overview",
    fluidPage(
      # Image banner at top of Overview page
      img(
        src = "la_traffic.jpg",
        width = "100%",
        height = "250px",
        style = "object-fit: cover;"
      ),
      titlePanel("Overview"),
      # Make navlistPanel layout
      navlistPanel(
        tabPanel(
          "Introduction",
          titlePanel("Introduction"),
          p(
            "Los Angeles City is the second largest city in the United States,
            with a population of 3.99 million (in 2018). As the",
            a(
              href = "https://la.curbed.com/2019/2/13/18222225/los-angeles-traffic-worst-nation-hours",
              "fifth-worst traffic ranked"
            ),
            "in the nation, this also means that there are a lot of traffic
            collisions. Because of this, we decided to build an interactive
            visualization application to analyze the most recent year of
            collision data to see if we could find helpful insights and patterns
            that may help guide policymakers."
          )
        ),
        tabPanel(
          "Data",
          titlePanel("Data"),
          p(
            "The dataset used in this analysis is the publicly available",
            a(
              href = "https://data.lacity.org/A-Safe-City/Traffic-Collision-Data-from-2010-to-Present/d5tf-ez2w/data",
              "LAPD's City Traffic Collision Data"
            ),
            "filtered by the most recent year available, which is all of 2019.
            The dataset contains 56,608 traffic collision incidents in the
            City of Los Angeles in the year 2019. This data
            was transcribed from original traffic reports that are typed on
            paper and so there may be some inaccuracies within the data.
            For example, some location fields with missing data are noted as
            (0°, 0°). also, address fields are only provided to the nearest
            hundred block in order to maintain privacy. This data is as
            accurate as the data in the database."
          )
        ),
        tabPanel(
          "Key Questions",
          titlePanel("Key Questions"),
          p("Here are the key questions we want to answer in this analysis."),
          tags$ul(
            tags$li("What demographic groups (age/gender/descent)
                    are most represented in the collision data?"),
            tags$li("What is the relationship between time of day,
                    day of week and the number of traffic incidents?"),
            tags$li("What areas are more congested and
                    accident prone, and at what times of day?"),
          )
        )
      ) # end navlistPanel
    ) # end fluidPage
  ) # end Overview tabPanel

  # Demographics page
  age_and_gender <- tabPanel(
    title = "Demographics",
    titlePanel("Accidents by Demographics"),
    sidebarLayout(
      sidebarPanel(
        # Interactivity widgets
        radioButtons(inputId = "select",
                     label = "Compare:",
                     choices = c("Gender", "Race"),
                     selected = "Gender"),
        selectInput(inputId = "gender",
                    label = "Gender",
                    choices = c("All",
                                "Male and Female",
                                "Male and Other",
                                "Female and Other"),
                    selected = "All"),
      ),
      mainPanel(
        plotlyOutput("age_and_gender"),
        h3("Visualization Justification:"),
        p("This interactive plot determines which demographic group
          (age/gender/race) is most represented in the data.
          This can help see whether demographic has a
          correlation with traffic accidents.
          The plot uses bars to determine this because it is very clear to see
          which demographic gets into accidents the most. The color was chosen
          to tell the difference between the different
          values that are on the plot.")
      )
    )
  )
  # Time and day page
  time_and_day <- tabPanel(
    title = "Time and Day",
    titlePanel("Accidents by Time and Day"),
    sidebarLayout(
      sidebarPanel(
        radioButtons(inputId = "graph",
                     label = "Select Graph:",
                     choices = c("Bar", "Linear"),
                     selected = "Bar"),
        selectInput(inputId = "time_selection",
                    label = "Select Time of Day (Bar Graph):",
                    choices = c("Total" = "total",
                                "Morning",
                                "Afternoon",
                                "Evening",
                                "Night"),
                    selected = "Total"),
        selectInput(inputId = "day_selection",
                    label = "Select Day (Linear Graph):",
                    choices = c("Monday",
                                "Tuesday",
                                "Wednesday",
                                "Thursday",
                                "Friday",
                                "Saturday",
                                "Sunday"
                                ),
                    selected = "Monday"
                    ),
        HTML("Definitions for Time <br/>
              Morning: 05:00 ~ 11:59 <br/>
              Afternoon: 12:00 ~ 16:59 <br/>
              Evening: 17:00 ~ 20:59 <br/>
              Night: 21:00 ~ 04:59")
        ),
      mainPanel(
        plotlyOutput("time_and_day"),
        h3("Visualization Justification:"),
        p("This page shows two separate graphs that allow you to
          find the number of accidents for each time of the day (bar graph),
          as well as each day of the week (linear graph). The options on the
          left are unique to each graph that is being displayed"),
        p("For the bar graph,
          the blue bar indicates the day with the most accidents
          during that time period while the red bar
          indicates the lowest amount of accidents on that day.
          For example, we can see that on Friday,
          the most accidents happened in the morning."),
        p("The linear graph shows the frequency of accidents throughout
          the day, and can tell us the times with the most accidents for
          each day of the week.")
      )
    )
  )

  # Collisions map page
  collisions_map <- tabPanel(
    title = "Area",
    titlePanel("Accidents by Area"),

    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "day",
          label = "Day of the week for vehicle collision",
          choices = c("All", "Monday", "Tuesday", "Wednesday", "Thursday",
                      "Friday", "Saturday", "Sunday")
        ),
        selectInput(
          inputId = "time",
          label = "Time of day for vehicle collision",
          choices = c("All", "Morning", "Afternoon", "Evening", "Night")
        ),
        HTML("Definitions for Time <br/>
              Morning: 05:00 ~ 11:59 <br/>
              Afternoon: 12:00 ~ 16:59 <br/>
              Evening: 17:00 ~ 20:59 <br/>
              Night: 21:00 ~ 04:59")
      ),
      mainPanel(
        leafletOutput("collisions_map", height = 500),
        h3("Visualization Justification:"),
        p("The purpose of this map is to compare the number of traffic accident
          occurences by area in Los Angeles. Users are able to
          choose to look at collisions in each area and compare the statistics
          to each day of the week or to the time of the day. The areas
          indicated by the map only show an approximate location for
          collisions due to privacy protection purposes.")
      )
    )
  )

  takeaways <- tabPanel(
    title = "Takeaways",
    titlePanel("Takeaways"),
    fluidPage(
      h2("Demographics"),
      p("According to the demographics collected,
        age range from 36 to 55 records the highest
        number of accidents.  Furthermore, regardless
        of age, males were involved in the highest number
        of accidents out of all genders."),
      p("The possible reason for this may be due to
        higher car ownership. Those who are in
        the age range from 36 to 55 are the ones
        that are actively involved in economic
        activities, they are more likely to be on
        the road. As a further implication, males
        are more likely to get involved in the business
        that requires heavy vehicle driving."),
      img(src = "summary_age.jpg",
          width = "70%%",
          height = "70%",
          style = "object-fit: cover;"),
      p("According to U.S. census bureau, Hispanic occupies
      48.6% while White records 52.4% in LA. Unofortunately, however,
      despite lesser population,
      majority of the victims were Hispanic descent."),
      p("The possible reason behind this could be geography.
        According to the dataset, most of the accidents happened in
        South La such as 77th street, Southwest. According to the
        census, Hispanic is a 61% of a population in these areas."),
      img(
        src = "summary_demographics.jpg",
        width = "40%%",
        height = "50%",
        style = "object-fit: cover;"
      ),
      h2("Time and Day"),
      p("Friday afternoon and evening record the highest number of
        accidents out of all times and days with the record of 2261 and
        2731 respectively. On the other hand, morning,
        afternoon, and evening of Sunday record the lowest
        number of accidents with 1440, 1590, 1965 respectively."),
      p("The possible reason for Friday recording the
        highest number of accidents may be due to
        an increase in floating population the
        possible rationales behind this are students
        going back home, people going out for dinner,
        and so on."),
      img(
        src = "summary_timeday.jpg",
        width = "60%%",
        height = "50%",
        style = "object-fit: cover;"
      ),
      h2("Area"),
      p("Looking at the map of collisions by area and clicking on
        the largest circle, we can see that the area with the highest
        overall number of collisions is 77th Street, with 3992 collisions
        in 2019."),
      img(
        src = "77th_street_all.png",
        width = "50%",
        height = "50%"
      ),
      p("Interacting with the day of week and time of day widgets
        give further insight into how the areas compare at different points
        in time. For example, if we choose 'All' for days of the week and
        and select different times of day, we see that the 77th Street area
        always has the highest number of collisions regardless of the
        time of day. However, if we choose 'All' for time of day and choose
        different days of the week, we see the Southwest area had more
        collisions on Wednesdays."),
      img(
        src = "southwest_wednesdays.png",
        width = "50%",
        height = "50%"
      ),
      p("This is just one example of an insight that can be gained from
        this visualization. Interacting with the widgets and looking at
        how different areas compare for each combination of day and time
        can reveal even more patterns that policy makers can further
        investigate to find what events might be the root cause and reduce
        collision hot spots. Furthermore, we envision that a visualization
        like this can also help drivers find the best day and time to travel
        in an area, or conversely find what areas to avoid at certain times
        for safer travel.")
    )
  )

  # Create navbar UI with the pages
  ui <- navbarPage(
    project_title,
    overview,
    age_and_gender,
    time_and_day,
    collisions_map,
    takeaways,
    theme = shinytheme("journal")
  )

  return(ui)
}
