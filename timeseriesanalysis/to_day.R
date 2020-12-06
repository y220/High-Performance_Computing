rm(list = ls())

args = (commandArgs(trailingOnly=TRUE))
if(length(args) == 1 & grep('sds',args[1])==1){
  filename = args[1]
} else {
  cat('usage: Rscript to_day.R  sds_filename.csv \n', file=stderr())
  stop()
}


# sds data
sds <- read.csv(paste('data/',filename,sep = ''))

# change time scale
sds$timestamp<-sub("T.*$", "", sds$timestamp)

# west park area
west_park.sds<-sds[sds$lat <= 42.720 & sds$lat >= 42.694 & sds$lon <= 23.304 & sds$lon >= 23.244,]

# calculate daily mean
wp.particles<-aggregate(cbind(P1, P2) ~ timestamp, data = west_park.sds, FUN = mean, na.rm = TRUE)

newname <- gsub("([0-9]{4})-([0-9]{2})_sds.*","\\1\\2",filename)
# write .csv data
write.csv(wp.particles, paste("TS_data/wp.particles",newname,"_day.csv",sep = ""), row.names = FALSE)

