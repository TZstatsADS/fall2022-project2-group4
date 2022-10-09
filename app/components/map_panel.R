source("./app/dependencies.R")

panel_name <- "Map"
map_panel_ui <- tabPanel(
    panel_name,
    sidebarLayout(
        sidebarPanel(
            width = 3, height = 10,
            sliderInput(
                inputId = "map_slider_input_id_1",
                label = "map_slider_input_label_1",
                min = 0,
                max = 10,
                value = 5
            ),
            selectInput(
                inputId = "map_select_input_id_1",
                label = "map_select_input_label_1",
                choices = c(
                    "Option 1",
                    "Option 2",
                    "Option 3"
                )
            )
        ), # end of sidebar panel

        mainPanel(
            plotOutput("map_output")
        )
    )
)
