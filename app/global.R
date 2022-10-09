source("./app/dependencies.R")
source("./app/server.R")
source("./app/ui.R")

app <- shinyApp(ui, server)
runApp(app)
