##############################################################################

#                                                                            #

#                          BiOiNFORMATiCs Project                            #

#                                                                            #

#             Colour-scale maps representing genetic diversity               #

#                                                                            #

##############################################################################

# Reading in Sampling data

#setwd("C:/Users/Aoife/Desktop/MB Masters ~ 2/Bioinformatics/project")

d <- read.table("newdataHI.txt", header = T)



#install.packages("mapdata")



#=======================================#

# Plot data on google earth with ggmap  #

#=======================================#



#install.packages("mapplots")

#install.packages("marmap")

#install.packages("maps")



library (mapdata)

library (maps)

library (fields)
library (png)
library(ggplot2)
library(ggmap)



# define ylim and xlim 

xlim <- c(min(d$Long)-1, max(d$Long)+1)

ylim <- c(min(d$Lat)-12.9, max(d$Lat)+12.9)



# Tps() function from fields package

# make lat and long into a matrix-> not compatible x <- as.matrix(d$Lat, d$Long)

x <- cbind(d$Long, d$Lat)

y <- d[,3]


leg = colnames(d)[3]



# use the tps function to fit the impacts

fit<- Tps(x,y, lambda=0)

png(paste("HumanImpacts_", leg, sep = ""),height=1000,width=1000)



surface(fit, xlim=xlim, ylim=ylim, xlab= "Longitude", ylab="Latitude", 
        main= paste("Human impacts of ", leg, sep = ""))

#        main= "Human impacts on allelic richness")

#map('worldHires',  add=TRUE)# change map type here

map('worldHires', add=TRUE, fill=TRUE, col='white', boundary='black', lwd = 2)



#add points

points(cbind(d$Long, d$Lat), pch=16, cex=d$Ho*10, col = alpha("black",0.8)) 

dev.off()

