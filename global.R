DEPLOY <- T
if (!DEPLOY) {

    if (basename(getwd()) != "app") {
        setwd("./app")
    }

    source("./dependencies.R")
    source("./server.R")
    source("./ui.R")
    source("./shinyapps_io.R")

    app <- shinyApp(
        ui,
        server,
        options = list(
            launch.browser = FALSE,
            autoload.r = TRUE
        )
    )
    runApp(app)
} else {
    rsconnect::deployApp(
        upload = TRUE,
        appName = "Group4-Applied_Data_Science",
        appTitle = "Project Oogway",
        appDir = "./app"
    )
}
