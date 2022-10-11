source("./app/dependencies.R")
source("./app/components/map_panel.R")

server <- function(input, output) {
    output$map_output <- renderLeaflet({
        leaflet_map
    })

    output$map_output <- 
    output$map_label_boroughs <- map_borough_label(input)
}