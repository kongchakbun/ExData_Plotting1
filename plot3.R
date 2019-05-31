## Load the package of "dplyr"
library(dplyr)

##unzip("./data/exdata_data_household_power_consumption.zip")

## Read the data and treat all the "?" as "NA"
powerConsumption <- read.table("./data/household_power_consumption.txt",
                               header = TRUE, sep = ";", na.strings="?")

## Treat the Date column as date.
powerConsumption$Date <- as.Date(powerConsumption$Date, "%d/%m/%Y")

## Select the rows within the related period..
powerConStudy <- filter(powerConsumption, Date >= "2007-02-01" & 
                                Date <= "2007-02-02")

## Merge the columns of "Date" and "Time"
powerConStudy <- mutate(powerConStudy, Date = paste(Date, Time))

## Remove the column of "Time"
powerConStudy <- select(powerConStudy, -(Time))

## Convert the class of "Date" to the format of POSIXlt.
powerConStudy$Date <- strptime(powerConStudy$Date, format ="%Y-%m-%d %H:%M:%S")

## Change the format of "Date" to the format of POSIXct.
powerConStudy$Date <- as.POSIXct(powerConStudy$Date)

## Open the graphic device.
png(file = "plot3.png", width = 480, height = 480)
## Plot the first line.
with(powerConStudy, plot(Date, Sub_metering_1, type = "l", xlab = "", 
                         ylab = "Energy sub metering"))
## Plot the second line.
lines(powerConStudy$Date, powerConStudy$Sub_metering_2, col = "red")
## Plot the third line.
lines(powerConStudy$Date, powerConStudy$Sub_metering_3, col = "blue")
## Add the legend
legend("topright", col = c("black", "red", "blue"), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), lwd = c(1,1))
## Close the graphic device.
dev.off()
