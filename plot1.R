### plot1.R

###This is an assignment in the course of Exploratory Data Analysis. 
###The assignment uses data from UC Irvine Machine Learning Repository. 
###dataset is the Electric power consumption
###the module include the functions below:
### getData -- to download the data
### loadData -- to load data 
### plot1 -- to make the plot 1


setwd("./") # set to an empty working directory. change accordingly. 


### step 1: download and unzip the data
getData <- function(){
   if (!file.exists("household_power_consumption.txt")){
      url <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(url, destfile = "temp.zip", method = "curl")
      unzip("temp.zip")
      file.remove("temp.zip")}
}

### step 2: loading and subsetting the data, etc. 
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

### just for plot 1
getData()
loadData()
plot1()