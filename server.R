shinyServer(function(input, output) {
  
  output$Shp_On <- renderUI({ if(is.null(shp())) br() else checkboxInput("shp_on", "Shapefile active", TRUE) })
  
  # MODULE: polygon shapefile upload and related reactive objects
  shp <- callModule(shpPoly, "user_shapefile")
  
  Shp_plot_ht <- reactive({
    if(is.null(shp())) return(0)
    e <- extent(shp()$shp_original)[]
    round(100*(e[4]-e[3])/(e[2]-e[1]))
  })
  
  output$Shp_Plot <- renderPlot({
    if(!is.null(shp())){
      cl <- class(shp()$shp_original)
      if(cl=="SpatialPointsDataFrame"){
        d <- data.frame(shp()$shp_original@coords, group=1)
        names(d) <- c("long", "lat", "group")
      } else d <- fortify(shp()$shp_original)
      g <- ggplot(d, aes(x=long, y=lat, group=group)) + coord_equal() + theme_blank
      if(cl=="SpatialPolygonsDataFrame"){
        g <- g + geom_polygon(fill="steelblue4") + geom_path(colour="gray20")
        if("hole" %in% names(d)) g <- g + geom_polygon(data=filter(d, hole==TRUE), fill="white")
      } else if(cl=="SpatialLinesDataFrame"){
        g <- g + geom_path(colour="steelblue4", size=2)
      } else {
        g <- g + geom_point(colour="steelblue4", size=2)
      }
    }
    g
  }, height=function() Shp_plot_ht(), bg="transparent")
  
  output$Mask_in_use <- renderUI({ if(is.null(shp())) h4("None") else plotOutput("Shp_Plot", height="auto") })
  
  output$Shp_On <- renderUI({ if(is.null(shp())) br() else checkboxInput("shp_on", "Shapefile active", TRUE) })
  
  # Download All Data
  output$download_all_data <- downloadHandler(
    # This function returns a string which tells the client browser what name to use when saving the file.
    filename = function() {
      paste0("all_OSWCR_cleaned", ".csv")
    },
    
    # This function should write data to a file given to it by the argument 'file'.
    content = function(file) {
      # Write to a file specified by the 'file' argument
      write.table(well_logs_sp@data, file, sep = ",", row.names = FALSE)
    }
  )
  
  # Download Clipped Data
  output$download_clipped_data <- downloadHandler(
    # This function returns a string which tells the client browser what name to use when saving the file.
    filename = function() {
      paste0("clipped_OSWCR_cleaned", ".csv")
    },
    
    # This function should write data to a file given to it by the argument 'file'.
    content = function(file) {
      # Write to a file specified by the 'file' argument
      write.table(shp()[[3]]@data, file, sep = ",", row.names = FALSE)
    }
  )
   
  # render download button if a shapfile is uploaded
  output$dwn_shp_pts <- renderUI({ if(is.null(shp())) br() else downloadButton("download_clipped_data", "Download Clipped Data") })
  
  
  # count number of wells returned by the clip
  output$n_wells <- renderText({ 
    ifelse(is.null(shp()),
           "No shapefile currently entered. Please enter a shapefile.",
           paste(nrow(shp()[[3]]@data), "wells were found within this shapefile. Click to zoom.")
    )
  })
  
  # create main leaflet, just a ca outline
  output$main_leaflet <- renderLeaflet({ leaflet(ca) %>%
      addTiles() %>%
      addPolygons()
  })

  # update the map once the user uploads a shapefile to show the shapefile plus the points in it
  observe({
    if(!is.null(shp())){ 
      m <- leafletProxy("main_leaflet") %>%
        clearShapes() %>%
        addPolygons(data = shp()[[1]]) %>%
        addMarkers(lng = shp()[[3]]@coords[, 1], lat = shp()[[3]]@coords[, 2],
                   clusterOptions = markerClusterOptions(),
                   popup = popupTable(shp()[[3]]@data, zcol = c("WCRNumber","WCR_PDF","lat","lon","top","bot","type") ))
      m$dependencies <- list(m$dependencies[[1]],css) # add pretty popupTable CSS from mapview
  
      # add basemaps
      for (provider in esri) {
        m <- m %>% addProviderTiles(provider, group = provider)
      }
      
      # plot leaflet
      m %>%
        addLayersControl(baseGroups = esri, #names(esri),
                         options = layersControlOptions(collapsed = FALSE)) %>%
        addMiniMap(tiles = esri[[1]], toggleDisplay = TRUE,
                   position = "bottomleft") %>%
        htmlwidgets::onRender("
                              function(el, x) {
                              var myMap = this;
                              myMap.on('baselayerchange',
                              function (e) {
                              myMap.minimap.changeLayer(L.tileLayer.provider(e.name));
                              })
                              }") %>% 
        addEasyButton(easyButton(
          icon="fa-globe", title="Zoom Out",
          onClick=JS("function(btn, map){ map.setZoom(9); }")))
    }
  })


})

# leaflet() %>%  
#   addTiles() %>% 
#   addPolygons(data = ca) %>%
#   addMarkers(lng = temp@coords[, 1], lat =temp@coords[, 2],
#              clusterOptions = markerClusterOptions(),
#              popup = popupTable(temp@data, zcol = c("WCRNumber","lat","lon"))) -> q
# length(q$dependencies)
# q$dependencies <- list(q$dependencies[[1]], css)
# q
