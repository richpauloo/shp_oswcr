suppressMessages({
  library(shiny)
  library(shinythemes)
  library(shinyBS)
  library(shinyjs)
  library(leaflet)
  library(DT)
  library(rgdal)
  library(raster)
  library(data.table)
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(mapview)
  library(readr)
})

source("mod_shpPoly.R")

# lat/lng
# ll <- crs("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")

# remove later, but use for now
# fp <- list()
# fp$app <- "C:/Users/rpauloo/Documents/GitHub/shp_oswcr/app"
# fp$data <- "C:/Users/rpauloo/Documents/GitHub/shp_oswcr/data"

#########################################

# preprocessing - get only wells with lat/lon
# oswcr well logs
#well_logs <- read_rds(paste(fp$data,"clean_dat_all.Rds", sep="/"))

# remove missing lat/lng
#well_logs <- dplyr::filter(well_logs, !is.na(lat) & !is.na(lon))
#write_rds(well_logs, paste(fp$data, "clean_with_ll.rds", sep = "/"))

# convert to sp
# well_logs_sp <- SpatialPointsDataFrame(coords = well_logs[, c("lon","lat")], 
#                                        data = well_logs, 
#                                        proj4string = ll)

# save as rds
#write_rds(well_logs_sp, paste(fp$data, "clean_with_ll_sp.rds", sep = "/"))

# read in WCR Links and save as rds
# wcr_links <- read_csv(paste(fp$data, "WCRLinks_201801.csv", sep = "/"))
# write_rds(wcr_links, paste(fp$data, "WCRLinks_201801.rds", sep = "/"))

#########################################


# # read in spatial points
# well_logs_sp <- read_rds(paste(fp$data, "clean_with_ll_sp.rds", sep = "/"))
# 
# # read in WCR links
# wcr_links <- read_rds(paste(fp$data, "WCRLinks_201801.rds", sep = "/"))



# read in spatial points
#well_logs_sp <- read_rds("data/clean_with_ll_sp.rds")
# well_logs_sp <- read_rds("data/clean_with_ll_sp.rds")
# well_logs_sp <- read_rds(paste(fp$app,"well_logs_sp.rds", sep="/")) # for local testing
#well_logs_sp <- read_rds("well_logs_sp.rds") # for use in shiny app


# read in WCR links
#wcr_links <- read_rds(paste(fp$app,"data", "WCRLinks_201801.rds", sep="/")) # for local testing
#wcr_links <- read_rds("data/WCRLinks_201801.rds") # for shiny app

# load(paste(fp$app, "nwt_communities.RData", sep = "/"))
# load("nwt_data_pr_tas_CRU32_1961_1990_climatology.RData")
# load("nwt_locations.RData")
# 
# d.gcm <- group_by(d.gcm, RCP, Model, Var) %>% arrange(Var, RCP, Model)
# d.cru <- group_by(d.cru, Var)
# r <- subset(cru6190$pr, 1)
# r <- read_rds("r.rds")
#ext <- c(round(xmin(r), 1), round(xmax(r), 1), round(ymin(r), 1), round(ymax(r), 1))
#lon <- (xmin(r)+xmax(r))/2
#lat <- (ymin(r)+ymax(r))/2

#ca <- read_rds(paste(fp$app, "data","ca.rds",sep="/")) # for local testing
ca <- read_rds("ca.rds") # for shiny app

# wells_with_wcr_link <- left_join(well_logs_sp@data, wcr_links, by = "WCRNumber") %>%
#   distinct(WCRNumber, .keep_all = TRUE)
# 
# well_logs_sp_wcr <- SpatialPointsDataFrame(coords = wells_with_wcr_link[, c("lon","lat")],
#                                            data = wells_with_wcr_link,
#                                            proj4string = ll)
# well_logs_sp_wcr <- spTransform(well_logs_sp_wcr, crs(well_logs_sp))
# write_rds(well_logs_sp_wcr, paste(fp$app, "data", "well_logs_sp_wcr.rds",sep="/"))

# well_logs_sp <- read_rds(paste(fp$app,"data","well_logs_sp_wcr.rds", sep="/")) # for local testing
# well_logs_sp@data <- well_logs_sp@data %>% 
#   mutate(WCR_PDF = paste0("<a href='",WCRLink,"'>Download WCR PDF</a>"))
# write_rds(well_logs_sp, paste(fp$app, "well_logs_sp.rds", sep = "/"))
well_logs_sp <- read_rds("well_logs_sp.rds") # for shiny app
# css <- read_rds(paste(fp$app, "data","css.rds",sep="/")) # for local testing
css <- read_rds("css.rds") # for shiny app

# get esri basemaps and add to leaflet
esri <- grep("^Esri", providers, value = TRUE)
esri <- c("OpenStreetMap","Esri.WorldImagery","Esri.WorldTerrain", "CartoDB.DarkMatter")

