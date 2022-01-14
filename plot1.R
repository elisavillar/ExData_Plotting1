##################################################################################################
#                                   PLOT NUMBER 1                                                #
##################################################################################################


## Install and load packages

install.packages("dplyr")

library(dplyr)

 
## Download, read and load file: "Individual household electric power consumption Data Set"

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url, dest="dataset.zip") 

unzip ("dataset.zip")

power_cons_data <- read.csv("household_power_consumption.txt", header = T, sep = ";", na.strings="?", 
                            nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')


## Filter only two first days of February 2007

power_cons_Feb_2007<- subset(power_cons_data, Date %in% c("1/2/2007","2/2/2007"))


## Convert Date from data set to class Date/Time

power_cons_data$Date <- as.Date(power_cons_data$Date, "%d/%m/%Y")


## Plot Global Active Power frequency

hist(power_cons_Feb_2007$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     col = "red")


## Plot to png

dev.copy(png, file =  "plot1.png", 
         width = 480, 
         height = 480, 
         units = "px")   

dev.off()   
