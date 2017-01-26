
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
mapgilbert <- get_map(location = c(Long = mean(d$Long), Lat = mean(d$Lat)), zoom = 4,
                      maptype = "satellite", scale = 2)


# plotting the map with some points on it
ggmap(mapgilbert) +
  geom_point(data = d, aes(x = Long, y = Lat, colour = Ho), size = 4, alpha=0.8, shape = 19)+ 
  scale_colour_gradient (low= "yellow", high = "red")




#====================================================================#


# Checkout- fields, maps & mapdata packages
# Within those packages, checkout tps, surface, maps & points functions
# fields package pg 41

library (mapdata)
library (maps)
library (fields)

# define ylim and xlim 
xlim <- c(min(d$Long)-0.1, max(d$Long)+0.1)
ylim <- c(min(d$Lat)-0.1, max(d$Lat)+0.1)

# Tps() function from fields package
#x <- as.matrix(d$Lat, d$Long)
# make lat and long into a matrix
x <- cbind(d$Long, d$Lat)
y <- d$cthreat

# use the tps function to fit the impacts
fit<- Tps(x,y, lambda=0)
surface(fit, xlim=xlim, ylim=ylim, xlab= "Longitude", ylab="Latitude", 
        main= "Human impacts on allelic richness")
#map('worldHires',  add=TRUE)# change map type here
map('worldHires', add=TRUE, fill=TRUE, col='white', boundary='black', lwd = 2)


# plot points per freq of alleles per locus
colours <- c("paleturquoise","darkslategray3","darkkhaki","thistle")
colours1 <- colours[d$Na]
points(d$Long, d$Lat, cex=(d$Na), pch=21, bg=colours1)



