## About this Application

* Enter a shapefile, and this R Shiny web application will return all wells in the <a href="https://water.ca.gov/Programs/Groundwater-Management/Wells" target="_blank">California Online State Well Completion Report Database (OSWCR)</a> that fall within that shapefile.  
* To accomplish this task, this application interfaces with a cleaned version of OSWCR, which contains nearly **900,000** cleaned wells. The steps used in the cleaning of this database are detailed [here](https://richpauloo.github.io/oswcr_1.html).
* The code for this project can be found in <ahref ="https://github.com/richpauloo/shp_oswcr" target="blank">this Github repository</a>.

***

# How to Use this Application

See this <a href = "https://youtu.be/DyF8WXNVZ-A">online instructional video</a> that accompanies the written instructions below.  

On the `Database Search Tab`:  

1. click `Upload Shapefile`. A popup window will appear.  
2. Enter the 6 required shapefile components *(.dbf, .prj, .sbn, .sbx, .shp and .shx)*, which can be done all at once by selecting multiple files.  
3. Click on `Clip Points to shapefile` to preform the clip, then close the window by clicking `close` in the lower right corner.  
4. Your clipped data will appear on the interactive map. Click on the numeric map marker to zoom into your area.  
5. Click on individual markers to access particular information about the well, including a link to download a PDF of the well completion report.  
6. Click on `Download clipped data` in the left hand toolbar to download a .csv of the clipped data points with all fields.  
7. Click on `Download all CA data` to download a .csv of all ~900,000 records. This may take a while.  


***  

## Contact Information

![](profile_pic.png) <br/> <br/>
Rich Pauloo, PhD Candidate | University of California Davis <br/>
<a href = "http://github.com/richpauloo" target = "blank">Github</a> | <a href ="https://richpauloo.github.io" target="blank">Website</a> | <a href ="https://www.linkedin.com/in/rpauloo" target="blank">LinkedIn</a>  

For questions specific to UC Water, please contact **Graham Fogg** <gefogg at ucdavis dot edu>.  
For questions about this web application, please contact **Rich Pauloo** <richpauloo at gmail dot com>.    

***

## Acknowledgments

In no particular order, I would like to thank:  

* Ben Breezing and the <a href = "https://water.ca.gov/" target="blank">California Department of Water Resources</a> for their assistance with data  
* the University of California Office of the President for the <a href = "http://ucwater.org/" target = "blank">UC Water Security and Sustainability Research Initiative</a>  
* <a href = "https://leonawicz.github.io/" target="blank">Matthew Leonawicz</a> for his open source R web apps that helped with building this app    


