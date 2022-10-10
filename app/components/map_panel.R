source("./app/dependencies.R")
source("./app/definitions.R")

# Map panel UI code

panel_name <- "Map"

panel_height <- 20
map_panel_ui <- tabPanel(
    panel_name,
    icon = icon("map-marker-alt"),
    fluidRow(
        leafletOutput(
            "map_output",
            height = 700
        )
    ), # end of map output fluidRow
    absolutePanel(
        id = "map_options_control", class = "panel panel-default custom-panel",
        fixed = TRUE, draggable = TRUE,
        top = 200, left = 50,
        right = "auto", bottom = "auto",
        width = 250, height = "auto",
        tags$h4("New York City Crashes"),
        tags$br(),
        pickerInput(
            inputId = "map_select_boroughs",
            choices = BOROUGHS
        ),
        fluidRow(
            column(
                width = 2,
                materialSwitch(
                    inputId = "map_switch_killed.injured",
                    label = "",
                    status = "danger"
                ),
                offset = 1
            ),
            column(
                width = 2,
                textOutput("map_label_boroughs"),
                offset = 1
            )
        ),
        prettyRadioButtons(
            inputId = "radio_vehicle_type",
            label = "Vehicle type:",
            choices = AFFECTED_PARTY,
            inline = TRUE,
            status = "danger",
            fill = TRUE
        )
    ), # end of absolute panel panel
    absolutePanel(
        id = "map_time_control", class = "panel panel-default custom-panel",
        fixed = FALSE,
        top = 100, left = 1500,
        right = "auto", bottom = "auto",
        width = 400, height = "auto",
        fluidRow(
            column(
                width = 10,
                sliderInput(
                    inputId = "map_slider_time",
                    label = "Time",
                    value = 0,
                    min = 0,
                    max = 1000,
                    step = 1,
                    ticks = FALSE,
                    animate = animationOptions(
                        interval = 333,
                        loop = FALSE,
                        playButton = NULL,
                        pauseButton = NULL
                    )
                ),
                offset = 1
            )
        ),
        # style = "opacity: 0.80"
    ) # end of time slider fluid row
)

# Map panel server code

# TODO: define map data
map_data <- NULL

leaflet_map <- leaflet(
    map_data,
    height = panel_height,
    options = leafletOptions(
        minZoom = 11,
        maxZoom = 13
    )
) %>%
    addTiles() %>%
    addProviderTiles(
        "CartoDB.Positron",
        options = providerTileOptions(
            noWrap = TRUE
        )
    ) %>%
    setView(
        lng = -73.9834,
        lat = 40.7504,
        zoom = 12
    )

map_borough_label <- function(input) {
    renderText({
        return(ifelse(
            input$map_switch_killed.injured,
            "Killed",
            "Injured"
        ))
    })
}