#Week 1 Project Assignment- Exploratory Data analysis
## Plot 1

## Reading the data into R from .txt file and only data within the dates of 
## 2007-02-01 to 2007-02-02 and removing missing values (coded as ?)

setwd("~/Week 1")
library(dplyr)
library(data.table)

dataset <- data.table::fread(input = "~/Week 1/household_power_consumption.txt",
                             na.strings = "?")
dataset[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
dataset <- dataset[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

#Plotting the histogram for plot 1

dataset[, Global_active_power := lapply(.SD, as.numeric),
        .SDcols = c("Global_active_power")]
png("plot1.png", width=480, height=480)
hist(dataset[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()