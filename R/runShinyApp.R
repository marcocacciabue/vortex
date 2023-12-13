
#' Run voRtex shiny app
#'
#' Deploys a server that runs the voRtex app locally
#'
#'
#' @return a shiny app
#' @export
#'
#' @examples
#' \dontrun{
#' voRtex::runShinyApp()
#' }
#'

runShinyApp <- function() {

  # find and launch the app
  appDir <- system.file("myapp", "app.R", package = "voRtex")
  shiny::runApp(appDir, display.mode = "normal")
}
