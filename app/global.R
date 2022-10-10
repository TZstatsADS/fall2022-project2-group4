source("./app/dependencies.R")
source("./app/server.R")
source("./app/ui.R")

app <- shinyApp(
    ui,
    server,
    options = list(
        launch.browser = FALSE,
        autoload.r = TRUE
    )
)
runApp(app)
