#source source files
source("./setup/setup.R")
# Source custom modules
source("./modules/module_map.R")
source("./modules/module_bar.R")
source("./modules/module_brgInData.R")

ui <- page_sidebar(
  # Set the CSS theme
  theme = bs_theme(
    bootswatch = "superhero",
    version = 5,
    success = "#86C7ED",
    "table-color" = "#86C7ED",
    base_font = font_google("Lato"),
    heading_font = font_face(family = "Open Sauce Sans",
                             src = "url('../OpenSauceSans-Regular.ttf') format('truetype')")
  ),
  
  # Add sidebar elements
  sidebar = sidebar(
    class = "bg-secondary",
    sidebar_content,
    brgInData_ui("newdat"),
    width = 250
  ),
  # Layout non-sidebar elements
  layout_columns(
    map_ui("map"),
    bar_ui("bar"),
    col_widths = c(12, 12),
    row_heights = c(4, 1.75)
  )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  data_react <- reactiveVal(data)
  
  brgInData_server("newdat", data_react)
  
  data_filtered <- select_group_server(id = "my-filters",
                                       data = reactive(data_react()),
                                       vars = reactive(c(
                                         "kingdom", "scientificName", "vernacularName"
                                       )))
  
  bar_server("bar", data_filtered)
  map_server("map", data_filtered)
}
# Run the application
shinyApp(ui = ui, server = server)