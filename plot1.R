## Read the hpc, subset the hpc to save memory and computational power
## convert the date and time to a unique column
## remove the now useless date column
## then convert all the other columns to the appropriate format

hpc <- read.csv2("household_power_consumption.txt", stringsAsFactor=FALSE, na.strings="?")
hpc <- subset(hpc, hpc$Date=="1/2/2007"|hpc$Date=="2/2/2007")
hpc$Time <- as.POSIXct(paste(hpc$Date, hpc$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
hpc <- hpc[, -1]
hpc[, 2:8] <- sapply(hpc[, 2:8], function(x) x <- as.numeric(x))

## Create a histogram plot of the GAP
png("plot1.png")
hist(hpc$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
