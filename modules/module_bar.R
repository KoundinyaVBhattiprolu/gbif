bar_ui <- function(id) {
  ns <- NS(id)
  card(plotOutput(ns("bar")))
}
bar_server <- function(id, data_filtered) {
  moduleServer(id, function(input, output, session) {
    output$bar <- renderPlot({
      data_filtered <- data_filtered()
      # Convert the date column to a datetime object
      data_filtered$eventDate <- ymd_hms(data_filtered$eventDate)
      # Create a new month column
      data_filtered$month <- format(data_filtered$eventDate, "%b")
      
      data_filtered <- data_filtered %>%
        drop_na(month) %>%
        group_by(kingdom, month) %>%
        summarise(Count = n())
      validate(need(
        nrow(data_filtered) != 0,
        "There are no records with Event date on them"
      ))
      ggplot(data_filtered) +
        geom_bar(aes(x = month, y = Count, fill = kingdom),
                 position = "stack",
                 stat = "identity") +
        labs(
          title = "Observed Species across Months grouped by Kingdom",
          subtitle = "",
          caption = "Source: http://www.gbif.org/",
          x = "Month",
          y = "Count"
        ) +
        theme_classic() +
        scale_x_discrete(labels = month.abb) +
        theme(
          plot.title = element_text(
            color = "#0099F8",
            size = 16,
            face = "bold"
          ),
          plot.caption = element_text(face = "bold")
        )
    })
  })
}