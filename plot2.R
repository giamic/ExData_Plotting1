## Read the hpc, subset the hpc to save memory and computational power
## convert the date and time to a unique column
## remove the now useless date column
## then convert all the other columns to the appropriate format

hpc <- read.csv2("household_power_consumption.txt", stringsAsFactor=FALSE, na.strings="?")
hpc <- subset(hpc, hpc$Date=="1/2/2007"|hpc$Date=="2/2/2007")
hpc$Time <- as.POSIXct(paste(hpc$Date, hpc$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
hpc <- hpc[, -1]
hpc[, 2:8] <- sapply(hpc[, 2:8], function(x) x <- as.numeric(x))

## Ensure that the weekdays are written in English
Sys.setlocale("LC_TIME", "C")

## Create a plot of GAP~time
png("plot2.png")
plot(hpc$Time, hpc$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
