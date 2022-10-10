source("./app/dependencies.R")
source("./app/components/subcomponents/plots_panel_1.R")
source("./app/components/subcomponents/plots_panel_2.R")
source("./app/components/subcomponents/plots_panel_3.R")

panel_name <- "Graphs"
graphs_panel_ui <- tabPanel(
    panel_name,
    icon = icon("fa-light fa-chart-line"),
    tabsetPanel(
        plots_panel_1,
        plots_panel_2,
        plots_panel_3
    )
)