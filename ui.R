shinyUI(
  navbarPage(theme=shinytheme("spacelab"), 
             title=HTML('<div><a href="http://ucwater.org/" target="_blank"><img src="./img/small_logo.png" width="80%"></a></div>'),
             tabPanel("Database Search", value="db"),
             tabPanel("About", value="about"),
             windowTitle="UC Water | OSWCR Database Filter",
             collapsible=TRUE,
             id = "tsp",
  
  # Application title
  #titlePanel("OSWCR Database Search"),
  
  # Sidebar with a slider input for number of bins 
  conditionalPanel("input.tsp=='db'",
                   # row 1
                   fluidRow(
                     column(8, 
                            h4("Interface to the CA Online State Well Completion Report Database"), 
                            h6("Exract Data from a Region of Interest"))
                   ),
                   # row 2
                   fluidRow(
                     sidebarPanel(
                            shpPolyInput("user_shapefile", "Upload polygon shapefile", "btn_modal_shp"),
                            actionButton("btn_modal_shp", "Upload shapefile", class="btn-block"),
                            uiOutput("Shp_On"),
                            uiOutput("dwn_shp_pts"),
                            tags$br(),
                            downloadButton("download_all_data", "Download All CA Data")),
                     column(8,
                            leafletOutput("main_leaflet"), 
                            textOutput("n_wells"))
                   )
  ),
  
  # about panel
  conditionalPanel("input.tsp=='about'", includeMarkdown("about.md"))
  )
)
  
                   
                   
#   sidebarLayout(
#     sidebarPanel(
#       shpPolyInput("user_shapefile", "Upload polygon shapefile", "btn_modal_shp"),
#       actionButton("btn_modal_shp", "Upload shapefile", class="btn-block"),
#       uiOutput("Shp_On"),
#       uiOutput("dwn_shp_pts"),
#       tags$br(),
#       downloadButton("download_all_data", "Download All CA Data")
#     ),
# 
#     mainPanel(
#       tabsetPanel(
#         # Show a plot of the shapfile's points
#         tabPanel("Map",
#           leafletOutput("main_leaflet"), 
#           textOutput("n_wells")
#         ),
#         tabPanel("About",
#           includeMarkdown("about.md") #source("about.R",local=T)$value)
#         )
#       )
#     )
#   )
# ))
