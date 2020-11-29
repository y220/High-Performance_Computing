# find data near west park
file_names<-list.files(path = "clean_data/")
sds_data<-file_names[grep("sds", file_names)]

## winter month: 11, 12, 1
## non-winter month: 2, 3, 4, 5, 6, 7, 8, 9, 10
winter_month<-c(11, 12, 1)
p1_winter<-c()
p2_winter<-c()
p1_nonwinter<-c()
p2_nonwinter<-c()

for (ind in 1:length(sds_data)) {
  sds<-read.csv(paste("clean_data/", sds_data[ind], sep = ""))
  month<-as.numeric(substr(sds_data[ind], start = 6, stop = 7))
  sub_area<-sds[sds$lat <= 42.720 & sds$lat >= 42.694 & sds$lon <= 23.304 & sds$lon >= 23.244, ]
  p1.mean<-mean(sub_area$P1)
  p2.mean<-mean(sub_area$P2)
  if (month %in% winter_month) {
    p1_winter<-c(p1_winter, p1.mean)
    p2_winter<-c(p2_winter, p2.mean)
  } else{
    p1_nonwinter<-c(p1_nonwinter, p1.mean)
    p2_nonwinter<-c(p2_nonwinter, p2.mean)
  }
}

# test for difference in PM2.5 between winter months and non-winter months
t.test(p1_winter, p1_nonwinter, alternative = "two.sided", var.equal = FALSE, paired = FALSE)

# test for difference in PM2.5 between winter months and non-winter months
t.test(p2_winter, p2_nonwinter, alternative = "two.sided", var.equal = FALSE, paired = FALSE)
