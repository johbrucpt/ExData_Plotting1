
# Set your working directory
setwd("D:/Coursera/R/Course_4")

# Downloading the data
if(!file.exists("data")){dir.create("data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,dest="dataset.zip", mode="wb")
unzip("dataset.zip", exdir = "data")

# Extract data and read table
# Only read in dates from 2007-02-01 to 2007-02-02
data <- read.csv("./data/household_power_consumption.txt", sep=";", na.strings="?")
data <- subset(data, Date =="1/2/2007" | Date =="2/2/2007")

# Convert date and time to the right format
Date <- as.Date(data$Date,format = "%d/%m/%Y")
Time <- strptime(data$Time, "%H:%M:%S")

data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# Convert Global_active_power to numeric
Global_active_power <- as.numeric(data$Global_active_power)

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# 1
plot(data$DateTime, data$Global_active_power, type="l", xlab = "", ylab = "Global Active Power" )

# 2
plot(data$DateTime, data$Voltage, type="l", xlab = "datetime", ylab = "Voltage" )

# 3
plot(data$DateTime, data$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering" )
lines(data$DateTime, data$Sub_metering_2, type="l", col = "red")
lines(data$DateTime, data$Sub_metering_3, type="l", col = "blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1), lwd=c(1,1),  bty = "n")

# 4
plot(data$DateTime, data$Global_reactive_power, type="l", xlab = "datetime", ylab = "Voltage" )

dev.off()