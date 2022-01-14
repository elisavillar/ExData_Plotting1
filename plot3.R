##################################################################################################
#                                   PLOT NUMBER 3                                                #
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

power_cons_Feb_2007$Date <- as.Date(power_cons_Feb_2007$Date, "%d/%m/%Y")


## Add column date_time 

date_time <- paste(as.Date(power_cons_Feb_2007$Date), power_cons_Feb_2007$Time)

power_cons_Feb_2007$date_time <- as.POSIXct(date_time)


## Plot Energy sub metering frequency by day of the week

with(power_cons_Feb_2007, {
  plot(Sub_metering_1~date_time, 
       type="l",
       ylab="Energy sub metering", 
       xlab="")
  lines(Sub_metering_2~date_time,col='Red')
  lines(Sub_metering_3~date_time,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## Plot to png

dev.copy(png, file =  "plot3.png", 
         width = 480, 
         height = 480, 
         units = "px")   

dev.off()  
