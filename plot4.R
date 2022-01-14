##################################################################################################
#                                   PLOT NUMBER 4                                                #
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


## Divide the screen to plot four graphics

par(mfrow = c(2,  2))

## Plot Global Active Power by day of the week

with(power_cons_Feb_2007, {
  plot(Global_active_power~date_time, 
       type="l",
       ylab = "Global Active Power",
       xlab = "")
})


## Plot Voltage frequency by day of the week

with(power_cons_Feb_2007, {
        plot(Voltage~date_time, 
             type="l",
             ylab = "Voltage",
             xlab = "datetime")
})


## Plot Energy sub metering frequency by day of the week

with(power_cons_Feb_2007, {
  plot(Sub_metering_1~date_time, 
       type="l",
       ylab="Energy sub metering", 
       xlab="")
  lines(Sub_metering_2~date_time,col='Red')
  lines(Sub_metering_3~date_time,col='Blue')
})
legend("topright", inset = .02, col=c("black", "red", "blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lty=0)


## Plot Global reactive power frequency by day of the week

with(power_cons_Feb_2007, {
        plot(Global_reactive_power~date_time, 
             type="l",
             xlab = "datetime")
})

## Plot to png

dev.copy(png, file =  "plot4.png", 
         width = 480, 
         height = 480, 
         units = "px")   

dev.off()  
