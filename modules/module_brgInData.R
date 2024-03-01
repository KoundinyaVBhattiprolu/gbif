brgInData_ui <- function(id) {
  ns <- NS(id)
  fluidRow(
    h4("Want to pull in more data? Use the below slider"),
    p(
      "IT TAKES FEW MINUTES TO PULL IN DATA, Please avoid making multiple requests",
      style = "color:red"
    ),
    sliderInput(
      ns("BringInMoreData"),
      "Observations to pull in from GBIF",
      min = 0,
      max = 40000,
      value = 0,
      step = 5000
    )
  )
}

brgInData_server <- function(id, data_react) {
  moduleServer(id, function(input, output, session) {
    observeEvent(input$BringInMoreData, {
      gbif_data_search <-
        occ_search(
          hasCoordinate = TRUE,
          limit = input$BringInMoreData,
          fields = c(
            'gbifID',
            'kingdom',
            'decimalLatitude',
            'decimalLongitude',
            'scientificName',
            'vernacularName',
            'eventDate'
          )
        )
      if (nrow(gbif_data_search$data) > 0) {
        data_react(gbif_data_search$data)
      }
    }, ignoreInit = TRUE)
    
  })
}