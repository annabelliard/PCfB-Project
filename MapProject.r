
# Reading in Sampling data
setwd("C:/Users/Aoife/Desktop/MB Masters ~ 2/Bioinformatics/project")
d <- read.table("pcfbproject2017.txt", header = TRUE)


#=======================================#
# Plot data on google earth with ggmap
#=======================================#

install.packages("mapplots")
install.packages("marmap")
install.packages("maps")

# loading the required packages
library(ggplot2)
library(ggmap)
library (automap)

# getting the map- defining the area
mapMed <- get_map(location = c(Long = mean(d$Long), Lat = mean(d$Lat)), zoom = 4,
                      maptype = "satellite", scale = 2)


# plotting the map with populations and Ho (Heterozygozity) in a gradient of low (yellow) to high (red)
ggmap(mapMed) +
  geom_point(data = d, aes(x = Long, y = Lat, colour = Ho), size = 4, alpha=0.8, shape = 19)+ 
  scale_colour_gradient (low= "yellow", high = "red")



#====================================================================#

# Making a human impact gradient map from the fields package

library (mapdata)
library (maps)
library (fields)
library (png)

# define ylim and xlim 
# extending the latitude as the initial map was contorted
xlim <- c(min(d$Long)-0.1, max(d$Long)+0.1)
ylim <- c(min(d$Lat)-12.9, max(d$Lat)+12.9)

# Tps() function from fields package
# make lat and long into a matrix
# cthreat stand for cumulative human impact
x <- cbind(d$Long, d$Lat)
y <- d$cthreat

# use the tps function to fit the impacts
fit<- Tps(x,y, lambda=0)
# save map as png in home directory
png("map.png",height=1000,width=1000)
surface(fit, xlim=xlim, ylim=ylim, xlab= "Longitude", ylab="Latitude", 
        main= "Human impacts on allelic richness")

#plot the map
map('worldHires', add=TRUE, fill=TRUE, col='white', boundary='black', lwd = 2)

# add data point with Ho (the higher the Ho the bigger the circle)
points(cbind(d$Long, d$Lat), pch=16, cex=d$Ho*10, col = alpha("black",0.8)) 
dev.off()



