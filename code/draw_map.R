library(ggplot2)
library(ggmap)

# import Sofia map from google
register_google(key = "AIzaSyCZPh5fCMBdR5Sa76SQ_ZDJW6f8PA4ssIc")
sofia_map<-get_googlemap(center = c(23.320, 42.660), zoom = 12, key = "AIzaSyCZPh5fCMBdR5Sa76SQ_ZDJW6f8PA4ssIc")
bounds<-as.numeric(attr(sofia_map, "bb"))

# read data
particles<-read.csv("clean_data/2019-06_sds011sof_result.csv")
particles<-particles[particles$P1 <= 500 & particles$P2 <= 300,]
# climate<-read.csv("clean_data/climate1707.csv")

# PM2.5
p1_map<-ggmap(sofia_map, base_layer = ggplot(particles, aes(lon, lat))) + 
            coord_map(ylim = bounds[c(1,3)], xlim = bounds[c(2,4)]) + 
            scale_color_gradient("PM2.5", 
                                 low = "yellow", high = "chocolate4", limits = c(0,sqrt(500)), 
                                 breaks = c(0,sqrt(10),sqrt(40),sqrt(100),sqrt(200),sqrt(320),sqrt(500)), 
                                 labels = c(0,10,40,100,200,320,500)) +
            theme_minimal() + 
            theme(axis.text = element_blank(), 
                  axis.title = element_blank(), 
                  legend.text.align = 0, 
                  legend.title = element_text(size = 30), 
                  legend.text = element_text(size = 25))
p1_map + geom_point(aes(color = sqrt(P1), size = P1, alpha = P1)) + 
         scale_size_continuous(range = c(1,8)) + 
         scale_alpha_continuous(range = c(0.5, 1)) + 
         guides(size = FALSE, alpha = FALSE, color = guide_colourbar(barheight = 35, barwidth = 2))
ggsave("image/pm2.5_1906.png", width = 12, height = 12)

# PM10
p2_map<-ggmap(sofia_map, base_layer = ggplot(particles, aes(lon, lat))) + 
            coord_map(ylim = bounds[c(1,3)], xlim = bounds[c(2,4)]) + 
            scale_color_gradient("PM10", 
                                 low = "yellow", high = "chocolate4", limits = c(0,sqrt(300)), 
                                 breaks = c(0,sqrt(10),sqrt(30),sqrt(50),sqrt(100),sqrt(160),sqrt(240), sqrt(300)), 
                                 labels = c(0,10,30,50,100,160,240,250)) +
            theme_minimal() + 
            theme(axis.text = element_blank(), 
                  axis.title = element_blank(), 
                  legend.text.align = 0, 
                  legend.title = element_text(size = 30), 
                  legend.text = element_text(size = 25))
p2_map + geom_point(aes(color = sqrt(P2), size = P2, alpha = P2)) + 
         scale_size_continuous(range = c(1,8)) + 
         scale_alpha_continuous(range = c(0.5, 1)) + 
         guides(size = FALSE, alpha = FALSE, color = guide_colourbar(barheight = 35, barwidth = 2))
ggsave("image/pm10_1906.png", width = 12, height = 12)
