library(ggplot2)
library(ggmap)

# import Sofia map from google
register_google(key = "AIzaSyCZPh5fCMBdR5Sa76SQ_ZDJW6f8PA4ssIc")
sofia_map<-get_googlemap(center = c(23.320, 42.660), zoom = 12, key = "AIzaSyCZPh5fCMBdR5Sa76SQ_ZDJW6f8PA4ssIc")
bounds<-as.numeric(attr(sofia_map, "bb"))

# read data
particles<-read.csv("clean_data/2017-07_sds011sof_result.csv")
particles<-particles[particles$P1 <= 500 & particles$P2 <= 300,]
# climate<-read.csv("clean_data/climate1707.csv")

# PM2.5
p1_map<-ggmap(sofia_map, base_layer = ggplot(particles, aes(lon, lat))) + 
            coord_map(ylim = bounds[c(1,3)], xlim = bounds[c(2,4)]) + 
            scale_color_gradient("PM2.5", 
                                 low = "green", high = "red", limits = c(0,sqrt(500)), 
                                 breaks = c(0,sqrt(20), sqrt(50),sqrt(100),sqrt(200),sqrt(300),sqrt(400),sqrt(500)), 
                                 labels = c(0,20,50,100,200,300,400,500)) +
            theme_minimal() + 
            theme(axis.text = element_blank(), 
                  axis.title = element_blank())
p1_map + geom_point(aes(color = sqrt(P1), size = P1, alpha = P1)) + 
         scale_size_continuous(range = c(1,8)) + 
         scale_alpha_continuous(range = c(0.5, 1)) + 
         guides(size = FALSE, alpha = FALSE)
ggsave("image/pm2.5_1707.png", width = 7, height = 7)

# PM10
p2_map<-ggmap(sofia_map, base_layer = ggplot(particles, aes(lon, lat))) + 
            coord_map(ylim = bounds[c(1,3)], xlim = bounds[c(2,4)]) + 
            scale_color_gradient("PM10", 
                                 low = "green", high = "red", limits = c(0,sqrt(300)), 
                                 breaks = c(0,sqrt(10),sqrt(30),sqrt(50),sqrt(100),sqrt(160),sqrt(240), sqrt(300)), 
                                 labels = c(0,10,30,50,100,160,240,250)) +
            theme_minimal() + 
            theme(axis.text = element_blank(), 
                  axis.title = element_blank())
p2_map + geom_point(aes(color = sqrt(P2), size = P2, alpha = P2)) + 
         scale_size_continuous(range = c(1,8)) + 
         scale_alpha_continuous(range = c(0.5, 1)) + 
         guides(size = FALSE, alpha = FALSE)
ggsave("image/pm10_1707.png", width = 7, height = 7)

# # temperature
# temp_map<-ggmap(sofia_map, base_layer = ggplot(climate, aes(lon, lat))) + 
#             coord_map(ylim = bounds[c(1,3)], xlim = bounds[c(2,4)]) + 
#             scale_color_gradient("Temperature", 
#                                  low = "blue", high = "red", limits = c(-10,40)) +  
#    #                              breaks = c(0,sqrt(100),sqrt(200),sqrt(300),20), 
#    #                             labels = seq(0,400,by = 100)) +
#             theme_minimal() + 
#             theme(axis.text = element_blank(), 
#                   axis.title = element_blank())
# temp_map + geom_point(aes(color = temperature, size = sqrt(abs(temperature)), alpha = abs(temperature))) + 
#            scale_size_continuous(range = c(1,8)) + 
#            scale_alpha_continuous(range = c(0.5, 1)) + 
#            guides(size = FALSE, alpha = FALSE)
# ggsave("image/temperature_1707.png")
# 
# # pressure
# pres_map<-ggmap(sofia_map, base_layer = ggplot(climate, aes(lon, lat))) + 
#             coord_map(ylim = bounds[c(1,3)], xlim = bounds[c(2,4)]) + 
#             scale_color_gradient("Pressure", 
#                                  low = "blue", high = "red", limits = c(90000,150000), 
#                                  breaks = c(0,sqrt(100),sqrt(200),sqrt(300),20), 
#                                  labels = seq(0,400,by = 100)) +
#             theme_minimal() + 
#             theme(axis.text = element_blank(), 
#                   axis.title = element_blank())
# pres_map + geom_point(aes(color = sqrt(pressure), size = pressure, alpha = pressure)) + 
#            scale_size_continuous(range = c(1,8)) + 
#            scale_alpha_continuous(range = c(0.5, 1)) + 
#            guides(size = FALSE, alpha = FALSE)
# ggsave("image/pressure_1707.png")
# 
# # humidity
# humd_map<-ggmap(sofia_map, base_layer = ggplot(climate, aes(lon, lat))) + 
#             coord_map(ylim = bounds[c(1,3)], xlim = bounds[c(2,4)]) + 
#             scale_color_gradient("Humidity", 
#                                  low = "brown", high = "drakgreen", limits = c(0,85)) +
#             theme_minimal() + 
#             theme(axis.text = element_blank(), 
#                   axis.title = element_blank())
# humd_map + geom_point(aes(color = sqrt(humidity), size = humidity, alpha = humidity)) + 
#            scale_size_continuous(range = c(1,8)) + 
#            scale_alpha_continuous(range = c(0.5, 1)) + 
#            guides(size = FALSE, alpha = FALSE)
# ggsave("image/humidity_1707.png")
# 
