library(shiny)

choices_list <- c("SQL", "Python", "R")

ui <- fluidPage(
  titlePanel("Basic Demo"), # Title
  sidebarLayout(
  sidebarPanel(
    checkboxGroupInput(
    inputId = "name1",
    label = "What are your favourite languages?",
    choices = choices_list
  ),

  actionButton(inputId = "button",
               label = "List the selections",
               icon = icon("question"))
),
mainPanel(textOutput(outputId = "name3"))
)
)

server <- function(input, output, session) {

  debug_msg <- function(...) {
    is_local <- Sys.getenv('SHINY_PORT') == ""
    in_shiny <- !is.null(shiny::getDefaultReactiveDomain())
    txt <- toString(list(...))
    if (is_local) message(txt)
    if (in_shiny) shinyjs::runjs(sprintf("console.debug(\"%s\")", txt))
  }

  observeEvent(input$button, {

    debug_msg("testing")

    output$name3 <- renderText(input$name1)
  })

  # output$name3 <- renderText({
  #   input$name1
  # }) |>
  #   bindEvent(input$button)

}

shinyApp(ui, server)