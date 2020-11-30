library(ggplot2)
file_names<-list.files(path = "clean_data/")
sds_data<-file_names[grep("sds", file_names)]

p1_mean=c()
p2_mean=c()
for (ind in 1:length(sds_data)) {
  sds<-read.csv(paste("clean_data/", sds_data[ind], sep = ""))
  sub_area<-sds[sds$lat <= 42.720 & sds$lat >= 42.694 & sds$lon <= 23.304 & sds$lon >= 23.244, ]
  p1.mean<-mean(sub_area$P1)
  p2.mean<-mean(sub_area$P2)
  p1_mean<-c(p1_mean,p1.mean)
  p2_mean<-c(p2_mean,p2.mean)
}
time<-gsub("_.*_.*","",sds_data)
name <-factor(time)
t = data.frame(name,as.numeric(p1_mean),as.numeric(p2_mean))
ggplot()+ geom_line(data=t,aes(x=time, y=p1_mean,group=1,colour="PM2.5"))+
  geom_line(data=t,aes(x=time, y=p2_mean,group=1,colour="PM10"))+
  xlab("Time")+ylab("AQI")+
  scale_colour_manual("",values = c("PM2.5"="red","PM10"="blue"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5),plot.title=element_text(hjust=0.5))+
  labs(title = "Pollution")

bme_data<-file_names[grep("bme", file_names)]

pre_mean=c()
tem_mean=c()
hum_mean=c()
for (ind in 1:length(bme_data)) {
  bme<-read.csv(paste("clean_data/", bme_data[ind], sep = ""))
  sub_area<-bme[bme$lat <= 42.720 & bme$lat >= 42.694 & bme$lon <= 23.304 & bme$lon >= 23.244, ]
  pre.mean<-mean(sub_area$pressure)
  tem.mean<-mean(sub_area$temperature)
  hum.mean<-mean(sub_area$humidity)
  pre_mean<-c(pre_mean,pre.mean)
  tem_mean<-c(tem_mean,tem.mean)
  hum_mean<-c(hum_mean,hum.mean)
}
time<-gsub("_.*_.*","",bme_data)
name <-factor(time)
t = data.frame(name,as.numeric(pre_mean))
ggplot()+ geom_line(data=t,aes(x=time, y=pre_mean,group=1))+
  xlab("Time")+ylab("Pressure")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5),plot.title=element_text(hjust=0.5))+
  labs(title = "Pressure")

t = data.frame(name,as.numeric(tem_mean))
ggplot()+ geom_line(data=t,aes(x=time, y=tem_mean,group=1))+
  xlab("Time")+ylab("Temperature")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5),plot.title=element_text(hjust=0.5))+
  labs(title = "Temperature")

t = data.frame(name,as.numeric(hum_mean))
ggplot()+ geom_line(data=t,aes(x=time, y=hum_mean,group=1))+
  xlab("Time")+ylab("Humidity")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5),plot.title=element_text(hjust=0.5))+
  labs(title = "Humidity")


mydata <- data.frame( 
  Group = c(rep("TRUE",length(t)), rep("FALSE",length(f))),
  Frequency = c(t, f)
)
ggboxplot(mydata, x="Group", y = "Frequency", color = "Group", palette = "jco",add = "jitter",short.panel.labs = FALSE)+
  stat_compare_means(method = "t.test",label.y=100)


