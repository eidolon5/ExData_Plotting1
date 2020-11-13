# Load data into R for dates from 2007-02-01 to 2007-02-02.
fname <- paste(getwd(), "household_power_consumption.txt", sep="/") 
pwrdf <- read.table(fname, sep=";", col.names = c("Date", "Time", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering1", "SubMetering2", "SubMetering3"), na.strings="?", skip = grep("1/2/2007", readLines(fnam)), nrows=2880)
pwrdf <- cbind(as.POSIXlt(paste(pwrdf$Date, pwrdf$Time), format="%d/%m/%Y %H:%M:%S"), pwrdf[3:9])
names(pwrdf) <- c("DateTime", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering1", "SubMetering2", "SubMetering3")

# Create & open a png file.
png(paste(getwd(), "plot4.png", sep="/"), width=480, height=480)
par(mfrow=c(2,2))

# Plot 1 from plot1.R:  Global Active Power in kW vs Date
plot(pwrdf$DateTime,pwrdf$GlobalActivePower, type="l", xlab="", ylab="Global active power (kilowatts)",ylim=c(0,6))

# Plot 2: Voltage vs Day ylim = [234, 246]
plot(pwrdf$DateTime, pwrdf$Voltage, type = "l", ylab="Voltage", xlab="datetime")

# Plot 3: Plot time series of Global Active Power vs Date
#dev.new(width=480, height=480, unit="px")
plot(pwrdf$DateTime, pwrdf$SubMetering1, type="l", col="black", ylab = "Energy sub metering", xlab="")
lines(pwrdf$DateTime, pwrdf$SubMetering2, type="l", col="red")
lines(pwrdf$DateTime, pwrdf$SubMetering3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=0.8)

# Plot 4: Global reactive power vs Date with ylim = [0,0.5]
plot(pwrdf$DateTime, pwrdf$GlobalReactivePower, type="l", ylim=c(0,0.5), ylab="Global_reactive_power", xlab="datetime")

# Close png file.
dev.off()