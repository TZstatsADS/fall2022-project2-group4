source("./app/dependencies.R")
source("./app/definitions.R")
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

if (DEPLOY) {
    rsconnect::deployApp(
        appName = "Group 4 - Applied Data Science",
        appTitle = "Project Oogway"
    )
} else{
    runApp(app)
}