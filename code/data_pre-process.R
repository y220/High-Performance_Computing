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
particles<-aggregate(cbind(P1, P2) ~ lat + lon, data = sds, FUN = mean, na.rm = TRUE)

# bme data
bme<-read.csv("data/2017-11_bme280sof.csv")

# change time scale
bme$timestamp<-sub("T.*$", "", bme$timestamp)

# calculate monthly mean
climate<-aggregate(cbind(pressure, temperature, humidity) ~ lat + lon, data = bme, FUN = mean, na.rm = TRUE)

# write .csv data
write.csv(particles, "clean_data/particles1707.csv", row.names = FALSE)
write.csv(climate, "clean_data/climate1707.csv", row.names = FALSE)
