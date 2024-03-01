map_ui <- function(id) {
  ns <- NS(id)
  card(
    card_header("Biodiversity acroos Poland", class = "h6 text-success"),
    leafletOutput(ns("map"))
  )
}
map_server <- function(id, data_filtered) {
  moduleServer(id, function(input, output, session) {
    output$map <- renderLeaflet({
      data_filtered <- data_filtered()
      validate(
        need(
          nrow(data_filtered) != 0,
          "There are no records with choosen filters, Please reset filter's and try again"
        )
      )
      
      factpal <-
        colorFactor(palette(viridis(9)), levels = data_filtered$kingdom)
      map <-
        leaflet(data_filtered) %>% addTiles(group = "OpenStreetMap") %>%
        addCircleMarkers(
          ~ decimalLongitude,
          ~ decimalLatitude,
          popup = data_filtered$species,
          radius = 2,
          weight = 5,
          opacity = 0.5,
          fill = TRUE,
          fillOpacity = 0.2,
          color = ~ factpal(kingdom),
          clusterOptions = markerClusterOptions()
        )
    })
  })
}