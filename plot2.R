# Load data into R for dates from 2007-02-01 to 2007-02-02.
fname <- paste(getwd(), "household_power_consumption.txt", sep="/") 
pwrdf <- read.table(fname, sep=";", col.names = c("Date", "Time", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering1", "SubMetering2", "SubMetering3"), na.strings="?", skip = grep("1/2/2007", readLines(fnam)), nrows=2880)
pwrdf <- cbind(as.POSIXlt(paste(pwrdf$Date, pwrdf$Time), format="%d/%m/%Y %H:%M:%S"), pwrdf[3:9])
names(pwrdf) <- c("DateTime", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering1", "SubMetering2", "SubMetering3")

# Create & open a png file.
png(paste(getwd(), "plot2.png", sep="/"), width=480, height=480)

# Plot time series of Global Active Power vs Date
#dev.new(width=480, height=480, unit="px")
plot(pwrdf$DateTime, pwrdf$GlobalActivePower, type="l", xlab = "Day", ylab = "Global Active Power (kilowatts)")

# Close png file.
dev.off()