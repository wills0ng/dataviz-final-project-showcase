# Final Project
Use this `README.md` file to describe your final project (as detailed on Canvas).

# Field of Interest: Traffic Data
### Why did we choose this field/domain? 
+ We decided to choose this field out of personal interest. We wanted to dive into the domain of traffic data to see if there are any areas of improvement that could be made for improving road safety.

+ Some examples of other data driven projects are as follows:<br>

    + [Data Source 1](https://www.kaggle.com/riteshsinha/drunken-driving-and-accidents-eda-using-bigquery) - This project looks at drunk driving and accidents related to it. It pulls data from US traffic fatality records and analyzes which states have the most fatalities in relation to drunk driving, along with a month-wise analysis and hour-of-the-day of when the accidents happened to see which month and hour of the day has the most and least amount of accidents.
    
    + [Data Source 2](https://flowingdata.com/2017/04/27/traffic-fatalities-when-and-where/) - This project analyzes traffic incidents that involved fatalities that happened in the year 2015. The data analysis for each incident is broken up between urban and rural areas, and it looks at the factors that caused each incident, such as alcohol, pedestrians, or weather.
    
     + [Data Source 3](https://www.kaggle.com/natevegh/traffic-accidents-in-los-angeles-eda) - This project looks at traffic accidents in LA. It shows graphs of many different topics such as total accidents per month to pinpoint how accidents increased over the years. It also shows the average age of the victims as well as races of who tends to get into more accidents.

+ Some data-driven questions we hope to answer about this domain are: 

    + Of pedestrian-related traffic accidents, who was at fault? (Ex: jay-walking, insurance fraud, etc.)
    + What percentage of drivers that were involved in an accident went over the speed limit?
    + Of all traffic-related fatalitied in major cities, what were the top causes (Ex: [MO Codes column](https://data.lacity.org/A-Safe-City/Traffic-Accidents-by-date/2mzm-av8t) in LA Traffic data)?
    + Are there any significant differences in weather-related accidents compared to clear weather?
    + Does time (time column) play a significant role in increased occurences of accidents? (rush-hour versus non-rush hour)

# Finding Data
### Identified data sources:
+ [LA Traffic Collision Data](https://data.lacity.org/A-Safe-City/Traffic-Collision-Data-from-2010-to-Present/d5tf-ez2w) was collected from police reports by the Los Angeles Police Department (LAPD).
    + The data is about LA traffic collisions from 2010 to present. It is transcribed from original traffic reports that were typed on paper. The dataset includes information about the incidents regarding its number of victims, geographical location, etc.
    + Observations (rows) = 523,746, Features (columns) = 18
    
+ [CHI Traffic Collision Data](https://data.cityofchicago.org/Transportation/Traffic-Crashes-Vehicles/68nd-jvt3)
was collected from police reports by the Chicago Police Department (CPD).
    + This dataset is about traffic crashes in the city of Chicago. Traffic crashes within the limits of Chicago city but do not have the CPD as their responding police agencies are excluded from this dataset. This dataset includes crash information regarding its date, posted speed limit, weather conditions, etc.
    + Observations (rows) = 813,669, Features (columns) = 72

+ [NYC Traffic Collision Data](https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Crashes/h9gi-nx95)
was collected from police reports by the New York Police Department NYPD.
    + Observations (rows) = 1,676,509 million, Features (columns) = 29

    + This dataset contains information about all motor vehicle incidents that are reported by the police in NYC. The data is collected from police reports (MV104-AN) which are required to be filled out when an incident results in either injuries, facilities, or damage of more than $1000. This dataset includes information such as the number of victims, the geographical location of the collision, the type of vehicle, etc.
    + Observations (rows) = 1,676,509, Features (columns) = 29
    
### Questions that can be answered using datasets from above:
+ Questions such as "What types of accidents cause the most injury?", "What percentage of drivers that caused an accident went over the speed limit?" can be answered directly as they are addressed in the columns explicitly.
+ Questions like "Do the make and model affect the car to get into more accidents?" can be answered to some extent as the type of vehicle is not notably mentioned on LA and Chicago data while it is mentioned in the data of NYC.