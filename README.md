# 1. Project Overview:

https://vkbhattiprolu.shinyapps.io/gbifbiodvrsty/ 

The app is designed to identify which species are observed in a specific location on the map. we can also observe which months have lot of observations. This data may lead the user to know when to travel to a particular location to see a particular animal or avoid it completely.

User is able to able to filter by kingdom, scientific name and vernacular name. Please note that the selctors are grouped.

# 2. Code Structure:

Code is modularised. you can also see a setup file where all libraries required are mentioned.

# 3. Dependencies:

renv is used so dependencies are not an issue

# 4. Data Handling:

Data is being pulled from rds file stored in data folder. it was pulled using occ_search with limit of 20000 observation only from poland. current pull in data is pulling it from all over the world.

# 5. Testing:

NO unit test cases as of now but will follow.

# 6 . Deployment:

Used shinyapps.io to deploy the app

# 7. Known Issues and Workarounds:
   data pull in is live and it takes time so avoid making multiple attempts, Action button should be added for this case.
