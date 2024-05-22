#Week 1 Project Assignment- Exploratory Data analysis
## Plot 4

## Reading the data into R from .txt file and only data within the dates of 
## 2007-02-01 to 2007-02-02 and removing missing values (coded as ?)

setwd("~/Week 1")
library(dplyr)
library(data.table)

dataset <- data.table::fread(input = "~/Week 1/ExData_Plotting1_NI/household_power_consumption.txt",
                             na.strings = "?")

dataset[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
dataset <- dataset[(dateTime >= "2007-02-01") & (dateTime <= "2007-02-03")]

#Plotting the 4 graphs for plot 4

dataset[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2)) #will create 4X4 graphs in one plot (in row order)

#graph 1

plot(x = dataset[, dateTime],
     y = dataset[, Global_active_power],
     type = "l", ##this is an lowercase L not the number 1
     xlab = "Day",
     ylab = "Global Active Power (killowatts)")

#graph 2

plot(dataset[, dateTime], 
     dataset[, Voltage], type = "l", xlab = "Day", ylab = "Voltage")

#graph 3

plot(x = dataset[,dateTime], y = dataset[, Sub_metering_1], type = "l", xlab = "Day", ylab = "Energy sub metering")
lines(x = dataset[, dateTime], y = dataset[, Sub_metering_2], col = "red")
lines(x = dataset[, dateTime], y = dataset[, Sub_metering_3], col = "blue")
legend("topright",
       col = c("black", "red", "blue"),
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), 
       lwd=c(1,1))

#graph 4

plot(dataset[, dateTime], dataset[, Global_reactive_power], type = "l", 
     xlab = "Day", ylab = "Voltage")

dev.off()

