#package needed to run the app
library(shiny)
library(rgbif)
library(leaflet)
library(tidyverse)
library(bslib)
library(bsicons)
library(thematic)
library(shinyWidgets)
library(viridis)
library(lubridate)
library(testthat)
library(datamods)
library(rmarkdown)

#pull in saved RDS data
data <- readRDS(file = "./data/occurencess.rds")

# Make layout elements
sidebar_content <-
  list(
    column(
      width = 12,
      p("Filter data with group module"),
      shinyWidgets::panel(
        select_group_ui(
          id = "my-filters",
          inline = FALSE,
          params = list(
            list(inputId = "kingdom", label = "kingdom"),
            list(inputId = "scientificName", label = "scientificName"),
            list(inputId = "vernacularName", label = "vernacularName")
          ),
          vs_args = list(
            search = TRUE,
            multiple = TRUE ,
            disableSelectAll = TRUE,
            disableOptionGroupCheckbox = TRUE,
            inline = FALSE
          )
        ),
        status = "primary"
      )
    ),
    p(
      "This app provides the visualisation of species occurrence data for Poland from the",
      a("Global Biodiversity Information Facility.", href = "http://www.gbif.org/")
    ),
    p(
      "The data was imported using",
      a("rgbif from ROpensci", href = "https://github.com/ropensci/rgbif"),
      "and the site was built in",
      a("RStudio", href = "https://www.rstudio.com/"),
      "with",
      a("Shiny.", href = "https://www.rstudio.com/products/shiny/")
    ),
    br(),
    br()
  )