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

# west park area
west_park.sds<-sds[sds$lat <= 42.720 & sds$lat >= 42.694 & sds$lon <= 23.304 & sds$lon >= 23.244,]

# calculate daily mean
wp.particles<-aggregate(cbind(P1, P2) ~ timestamp, data = west_park.sds, FUN = mean, na.rm = TRUE)

# write .csv data
write.csv(wp.particles, "clean_data/wp.particles1707_day.csv", row.names = FALSE)
