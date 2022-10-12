source("./dependencies.R")
source("./datasets.R")

panel_width <- "33%"
offset_left <- 2
offset_right <- 5

plots_panel_3 <- tabPanel(
    "Graphs 3",
    fluidRow(
        column(
            width = 3,
            prettyRadioButtons(
                inputId = "graphs_radio_vehicle_type",
                label = "Vehicle type:",
                choices = AFFECTED_PARTY,
                inline = TRUE,
                status = "danger",
                fill = TRUE
            )
        ),
        column(
            width = 3,
            pickerInput(
                inputId = "graphs_select_boroughs",
                choices = BOROUGHS,
                selected = "ALL"
            )
        )
    ),
    verticalLayout(
        fluid = TRUE,
        fluidRow(
            splitLayout(
                cellWidths = panel_width,
                cellArgs = list(style = "padding: 6px"),
                plotOutput(
                    "plot_volume_3"
                ),
                plotOutput(
                    "plot_no_collisions_3"
                )
            )
        ),
        fluidRow(
            splitLayout(
                cellWidths = panel_width,
                cellArgs = list(style = "padding: 20px"),
                plotOutput(
                    "plot_total_injuries_3"
                ),
                plotOutput(
                    "plot_total_deaths_3"
                )
            )
        ),
        fluidRow(
            splitLayout(
                cellWidths = panel_width,
                cellArgs = list(style = "padding: 6px"),
                plotOutput(
                    "plot_injuries_per_collision_3"
                ),
                plotOutput(
                    "plot_death_per_collision_3"
                )
            )
        )
    )
)

plot_volume_3 <- daily_traffic %>%
    select(date, total) %>%
    group_by(date = lubridate::floor_date(date, "month")) %>%
    summarise(volume = sum(total)) %>%
    ggplot(aes(x = date, y = volume)) +
    geom_line()

plot_no_collisions_3 <- daily_crashes %>%
    select(date, total_accidents) %>%
    group_by(date = lubridate::floor_date(date, "month")) %>%
    summarise(
        total_accidents = sum(total_accidents)
    ) %>%
    ggplot(aes(x = date, y = total_accidents)) +
    geom_line()

plot_total_injuries_3 <- daily_crashes %>%
    select(date, ends_with("injured")) %>%
    group_by(date = lubridate::floor_date(date, "month")) %>%
    summarise(
        total_injured = sum(
            number_of_persons_injured,
            number_of_pedestrians_injured,
            number_of_cyclist_injured,
            number_of_motorist_injured
        )
    ) %>%
    ggplot(aes(x = date, y = total_injured)) +
    geom_line()

plot_total_deaths_3 <- daily_crashes %>%
    select(date, ends_with("killed")) %>%
    group_by(date = lubridate::floor_date(date, "month")) %>%
    summarise(
        total_killed = sum(
            number_of_persons_killed,
            number_of_pedestrians_killed,
            number_of_cyclist_killed,
            number_of_motorist_killed
        )
    ) %>%
    ggplot(aes(x = date, y = total_killed)) +
    geom_line()

plot_injuries_per_collision_3 <- daily_crashes %>%
    select(date, ends_with("injured")) %>%
    group_by(date = lubridate::floor_date(date, "month")) %>%
    summarise(
        injuries_per_collision = sum(
            number_of_persons_injured,
            number_of_pedestrians_injured,
            number_of_cyclist_injured,
            number_of_motorist_injured
        ) / n()
    ) %>%
    ggplot(aes(x = date, y = injuries_per_collision)) +
    geom_line()

plot_death_per_collision_3 <- daily_crashes %>%
    select(date, ends_with("killed")) %>%
    group_by(date = lubridate::floor_date(date, "month")) %>%
    summarise(
        deaths_per_collision = sum(
            number_of_persons_killed,
            number_of_pedestrians_killed,
            number_of_cyclist_killed,
            number_of_motorist_killed
        ) / n()
    ) %>%
    ggplot(aes(x = date, y = deaths_per_collision)) +
    geom_line()