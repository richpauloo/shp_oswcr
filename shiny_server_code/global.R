lp <- "/zeolite/rpauloo/R/x86_64-pc-linux-gnu-library/3.4"

#suppressMessages({
  library(sp, lib.loc = lp)
  library(shiny, lib.loc = lp)
  library(shinythemes, lib.loc = lp)
  library(shinyBS, lib.loc = lp)
  library(shinyjs, lib.loc = lp)
  library(leaflet, lib.loc = lp)
  library(DT, lib.loc = lp)
  library(rgdal, lib.loc = lp)
  library(raster, lib.loc = lp)
  library(data.table, lib.loc = lp)
  library(tidyr, lib.loc = lp)
  library(ggplot2)
  library(mapview, lib.loc = lp)
  library(readr, lib.loc = lp)
  library(sf, lib.loc = lp)
#})

source("mod_shpPoly.R")                      # module handles shapefile user input

ca <- read_rds("ca.rds")                     # california shapefile

well_logs_sp <- read_rds("well_logs_sp.rds") # well logs shapefile

css <- read_rds("css.rds")                   # CSS for leaflet popup table

# get esri basemaps and add to leaflet
esri <- c("OpenStreetMap","Esri.WorldImagery","Esri.WorldTerrain", "CartoDB.DarkMatter")
