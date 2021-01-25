library(shiny)
library(DT)
options(shiny.port = 1234)

ui <- navbarPage(
  title = "MarineEnergy.app", id = 'nav',
  tabPanel(
    "Configure",
    plotOutput("distPlot")),
  tabPanel(
    "Literature",
    selectInput(
      "species", 
      "Select Species", choices = c("setosa", "virginica"), 
      multiple = T, selected = NULL),
    dataTableOutput("tbl1")),
  tabPanel(
    "Spatial",
    "TBD"),
  tabPanel(
    "Reports",
    "TBD")
)

server <- function(input, output, session) {
  observe({
    query <- parseQueryString(session$clientData$url_search)
    if(!is.null(query$nav)) {
      nav <- strsplit(query$nav,"/")[[1]]
      updateTabsetPanel(session, 'nav', nav)
    }
  })
  
  output$distPlot <- renderPlot({
    hist(rnorm(100), col = 'darkgray', border = 'white')
  })
  
  output$tbl1 <- renderDataTable({
    tmp <- iris
    if(!is.null(input$species))
      tmp <- iris[which(iris$Species %in% input$species), ]
    
    datatable(tmp)
  })
}

shinyApp(ui = ui, server = server)