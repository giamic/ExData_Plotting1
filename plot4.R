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

## Create a grid of four plots
png("plot4.png")
par(mfrow = c(2,2))
with(hpc, plot(Time, Global_active_power, type="l", col="black", xlab="", ylab="Global active power"))
with(hpc, plot(Time, Voltage, type="l", col="black", xlab="datetime", ylab="Voltage"))
with(hpc, plot(Time, Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering"))
with(hpc, lines(Time, Sub_metering_2, col="red"))
with(hpc, lines(Time, Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black","red","blue"), bty="n")
with(hpc, plot(Time, Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power"))
dev.off()
