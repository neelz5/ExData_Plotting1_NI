#Week 1 Project Assignment- Exploratory Data analysis
## Plot 3

## Reading the data into R from .txt file and only data within the dates of 
## 2007-02-01 to 2007-02-02 and removing missing values (coded as ?)

setwd("~/Week 1")
library(dplyr)
library(data.table)

dataset <- data.table::fread(input = "~/Week 1/ExData_Plotting1_NI/household_power_consumption.txt",
                             na.strings = "?")

dataset[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
dataset <- dataset[(dateTime >= "2007-02-01") & (dateTime <= "2007-02-03")]

#Plotting the graph for plot 3

dataset[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
png("plot3.png", width=480, height=480)

plot(x = dataset[,dateTime], y = dataset[, Sub_metering_1], type = "l", xlab = "Day", ylab = "Energy sub metering")
lines(x = dataset[, dateTime], y = dataset[, Sub_metering_2], col = "red")
lines(x = dataset[, dateTime], y = dataset[, Sub_metering_3], col = "blue")
legend("topright",
       col = c("black", "red", "blue"),
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), 
       lwd=c(1,1))
dev.off()