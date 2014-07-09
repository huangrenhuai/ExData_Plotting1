### plotting.R


### step1: Loading data.
setwd("./") # set to an empty working directory. change accordingly. 

### download and unzip the data
getData <- function(){
   if (!file.exists("household_power_consumption.txt")){
      url <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(url, destfile = "temp.zip", method = "curl")
      unzip("temp.zip")
      file.remove("temp.zip")}
}

### load the data
loadData <- function(){
   message("loading a table with a size of 20 Mb")
   file1 <- "./household_power_consumption.txt" 
   myData <- read.csv2(file1, stringsAsFactors = FALSE, na.strings = "?")
             #colClasses = c(rep("charater",2), rep("numeric", 7)))

   myData$Date <- as.Date(myData$Date, format = "%d/%m/%Y")
   subData <- subset(myData, Date >= as.Date("2007-02-01"))
   subData <- subset(subData, Date <= as.Date("2007-02-02"))
   subData$datetime <- with(subData, paste(Date, Time))
   subData$datetime <- strptime(subData$datetime, format = "%Y-%m-%d %H:%M:%S")
   subData <<- subData
   for (i in 3:9) subData[, i] <<- as.numeric(subData[, i])
}

### Plot 1
plot1 <- function(){
   png(file = "plot1.png")
   with(subData, hist(as.numeric(Global_active_power), col="red", xlab = "Global Active Power (kilowatts)",main="Global Active Power"))
   # dev.copy(png, filename = "plot1.png")
   dev.off()
}

### Plot 2
plot2 <- function(mode = "png"){
   png(file = "plot2.png")
   with(subData, plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l"))
   #with(subData, lines(datetime, Global_active_power))
   dev.off()
}


### plot 3
plot3 <- function() {
   png(file="plot3.png")
   with(subData, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", col = "black", type = "l", lwd=1.2))
   with(subData, lines(datetime, Sub_metering_2, col = "red", lwd=1.2))
   with(subData, lines(datetime, Sub_metering_3, col = "blue", lwd=1.2))
   legend("topright", lty =1,lwd=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
   dev.off()
}

### plot 4
