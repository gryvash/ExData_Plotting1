graphics.off()
rm(list=ls())
mFileName <- "exdata-data-household_power_consumption.zip"
# Download the raw data if not exist yet
if(!file.exists(mFileName))
{
        mFileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(mFileURL, destfile = mFileName)
}

# Unpack the data if not exist yet
if(!file.exists("household_power_consumption.txt"))
{
        unzip(mFileName, exdir = ".")
}

# Get data names as only fraction of the data will be read
mDataNames <- read.csv2("household_power_consumption.txt", header = FALSE, stringsAsFactors = FALSE, nrows = 1)
# Read only the data from first two days in Feb 2007
mData <- read.csv2("household_power_consumption.txt", header = FALSE, stringsAsFactors = FALSE, na.strings = "?", skip = 66637, nrows = 2880)
# Set data names
names(mData) <- mDataNames
# Add column with datetime
mData$DateTime <- as.POSIXct(paste(mData$Date, mData$Time), format="%d/%m/%Y %H:%M:%S")

# Make plot
par(bg = "transparent")
plot(mData$DateTime, mData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Copy to file and close all graphics devices
dev.copy(png, file="plot2.png")
graphics.off()
