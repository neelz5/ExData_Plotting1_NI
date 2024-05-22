#Week 1 Project Assignment- Exploratory Data analysis
## Plot 2

## Reading the data into R from .txt file and only data within the dates of 
## 2007-02-01 to 2007-02-02 and removing missing values (coded as ?)

setwd("~/Week 1")
library(dplyr)
library(data.table)

dataset <- data.table::fread(input = "~/Week 1/ExData_Plotting1_NI/household_power_consumption.txt",
                             na.strings = "?")

dataset[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
dataset <- dataset[(dateTime >= "2007-02-01") & (dateTime <= "2007-02-03")]

#Plotting the line graph for plot 2
                   
dataset[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
png("plot2.png", width=480, height=480)
plot(x = dataset[, dateTime],
     y = dataset[, Global_active_power],
     type = "l", ##this is an lowercase L not the number 1
     xlab = "Day",
     ylab = "Global Active Power (killowatts)")
dev.off()