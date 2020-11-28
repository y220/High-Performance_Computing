rm(list = ls())

# args = (commandArgs(trailingOnly=TRUE))
# if(length(args) == 1){
#   data = args[1]
# } else {
#   cat('usage: Rscript sofia.R  <data>\n', file=stderr())
#   stop()
# }


# sds data
sds <- read.csv('data/2017-07_sds011sof.csv')

# change time scale
sds$timestamp<-sub("T.*$", "", sds$timestamp)

# calculate monthly mean
particles<-aggregate(cbind(P1, P2) ~ location, data = sds, FUN = mean, na.rm = TRUE)
loc1<-particles$location
latlon1<-apply(as.matrix(loc1), MARGIN = 1, 
               FUN = function(x){lat<-unique(sds$lat[sds$location == x]); 
                                 lon<-unique(sds$lon[sds$location == x]); 
                                 return(c("lat" = lat, "lon" = lon))})
particles<-cbind(particles, t(latlon1))



# bme data
bme<-read.csv("data/2017-07_bme280sof.csv")

# change time scale
bme$timestamp<-sub("T.*$", "", bme$timestamp)

# calculate monthly mean
climate<-aggregate(cbind(pressure, temperature, humidity) ~ location, data = bme, FUN = mean, na.rm = TRUE)
loc2<-climate$location
latlon2<-apply(as.matrix(loc2), MARGIN = 1, 
               FUN = function(x){lat<-unique(bme$lat[bme$location == x]); 
                                 lon<-unique(bme$lon[bme$location == x]); 
                                 return(c("lat" = lat, "lon" = lon))})
climate<-cbind(climate, t(latlon2))

write.csv(particles, "clean_data/particles1707.csv", row.names = FALSE)
write.csv(climate, "clean_data/climate1707.csv", row.names = FALSE)
