library(ggplot2)
library(ggmap)

# import Sofia map from google
register_google(key = "AIzaSyCZPh5fCMBdR5Sa76SQ_ZDJW6f8PA4ssIc", write = TRUE)
sofia_map<-get_googlemap(center = c(23.320, 42.660), zoom = 12, key = "AIzaSyCZPh5fCMBdR5Sa76SQ_ZDJW6f8PA4ssIc")
bounds<-as.numeric(attr(sofia_map, "bb"))

# read data
particles<-read.csv("clean_data/particles1707.csv")
climate<-read.csv("clean_data/climate1707.csv")

# PM2.5
p1_map<-ggmap(sofia_map, base_layer = ggplot(particles, aes(lon, lat))) + 
            coord_map(ylim = bounds[c(1,3)], xlim = bounds[c(2,4)]) + 
            scale_fill_gradientn("PM2.5", 
                               colors = c("darkgreen", "green", "yellow", "orange", "red", "darkred"), 
                               values = scales::rescale(c(0, 5, 12, 20, 35, 50))) + 
            scale_color_gradientn("PM2.5", 
                                colors = c("darkgreen", "green", "yellow", "orange", "red", "darkred"), 
                                values = scales::rescale(c(0, 5, 12, 20, 35, 50))) + 
            theme_minimal() + 
            theme(axis.text = element_blank(), 
                  axis.title = element_blank())
p1_map + geom_point(aes(color = P1, size = P1, alpha = P1)) + 
         scale_size_continuous(range = c(1,8)) + 
         scale_alpha_continuous(range = c(0.5, 1)) + 
         guides(size = FALSE, alpha = FALSE)
ggsave("image/p1_1707.png")

# PM10
p2_map<-ggmap(sofia_map, base_layer = ggplot(particles, aes(lon, lat))) + 
            coord_map(ylim = bounds[c(1,3)], xlim = bounds[c(2,4)]) + 
            scale_fill_gradientn("PM10", 
                               colors = c("darkgreen", "green", "yellow", "orange", "red", "darkred"), 
                               values = scales::rescale(c(0, 5, 12, 20, 35, 50))) + 
            scale_color_gradientn("PM10", 
                                colors = c("darkgreen", "green", "yellow", "orange", "red", "darkred"), 
                                values = scales::rescale(c(0, 5, 12, 20, 35, 50))) + 
            theme_minimal() + 
            theme(axis.text = element_blank(), 
                  axis.title = element_blank())
p2_map + geom_point(aes(color = P2, size = P2, alpha = P2)) + 
         scale_size_continuous(range = c(1,8)) + 
         scale_alpha_continuous(range = c(0.5, 1)) + 
         guides(size = FALSE, alpha = FALSE)
ggsave("image/p2_1707.png")

# temperature
temp_map<-ggmap(sofia_map, base_layer = ggplot(climate, aes(lon, lat))) + 
            coord_map(ylim = bounds[c(1,3)], xlim = bounds[c(2,4)]) + 
            scale_fill_gradientn("Temperature", 
                               colors = c("blue", "lightblue", "white", "pink", "red", "darkred"), 
                               values = scales::rescale(c(-20, 0, 15, 24, 30, 40))) + 
            scale_color_gradientn("Temperature", 
                                colors = c("blue", "lightblue", "white", "pink", "red", "darkred"), 
                                values = scales::rescale(c(-20, 0, 15, 24, 30, 40))) + 
            theme_minimal() + 
            theme(axis.text = element_blank(), 
                  axis.title = element_blank())
temp_map + geom_point(aes(color = temperature, size = temperature, alpha = temperature)) + 
           scale_size_continuous(range = c(1,8)) + 
           scale_alpha_continuous(range = c(0.5, 1)) + 
           guides(size = FALSE, alpha = FALSE)
ggsave("image/temperature_1707.png")

# pressure
pres_map<-ggmap(sofia_map, base_layer = ggplot(climate, aes(lon, lat))) + 
            coord_map(ylim = bounds[c(1,3)], xlim = bounds[c(2,4)]) + 
            scale_fill_gradientn("Pressure", 
                               colors = c("darkgreen", "green", "lightgreen", "yellow", "orange", "darkred"), 
                               values = scales::rescale(c(85000, 90000, 93500, 95000, 98000))) + 
            scale_color_gradientn("Pressure", 
                                colors = c("darkgreen", "green", "lightgreen", "yellow", "orange", "darkred"), 
                                values = scales::rescale(c(85000, 90000, 93500, 95000, 98000))) + 
            theme_minimal() + 
            theme(axis.text = element_blank(), 
                  axis.title = element_blank())
pres_map + geom_point(aes(color = pressure, size = pressure, alpha = pressure)) + 
           scale_size_continuous(range = c(1,8)) + 
           scale_alpha_continuous(range = c(0.5, 1)) + 
           guides(size = FALSE, alpha = FALSE)
ggsave("image/pressure_1707.png")

# humidity
humd_map<-ggmap(sofia_map, base_layer = ggplot(climate, aes(lon, lat))) + 
            coord_map(ylim = bounds[c(1,3)], xlim = bounds[c(2,4)]) + 
            scale_fill_gradientn("Humidity", 
                               colors = c("brown", "orange", "yellow", "lightgreen", "green", "darkgreen"), 
                               values = scales::rescale(c(0, 45, 47, 50, 53, 72))) + 
            scale_color_gradientn("Humidity", 
                                colors = c("brown", "orange", "yellow", "lightgreen", "green", "darkgreen"), 
                                values = scales::rescale(c(0, 45, 47, 50, 53, 72))) + 
            theme_minimal() + 
            theme(axis.text = element_blank(), 
                  axis.title = element_blank())
humd_map + geom_point(aes(color = humidity, size = humidity, alpha = humidity)) + 
           scale_size_continuous(range = c(1,8)) + 
           scale_alpha_continuous(range = c(0.5, 1)) + 
           guides(size = FALSE, alpha = FALSE)
ggsave("image/humidity_1707.png")

