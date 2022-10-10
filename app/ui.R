

repository_url <- "https://github.com/TZstatsADS/fall2022-project2-group4/tree/master" # nolint
source("./app/dependencies.R")
source("./app/components/main_panel.R")
source("./app/components/map_panel.R")
source("./app/components/graphs_panel.R")

ui <- fluidPage(
  theme = shinytheme("journal"),
  title = "Group 4 Project", # TODO: change this name
  navbarPage(
    a(
      href = repository_url,
      "Group 4 Project"
    ),
    map_panel_ui,
    graphs_panel_ui,
    main_panel_ui,
  ),
  includeCSS("./app/css/panel_styles.css")
)