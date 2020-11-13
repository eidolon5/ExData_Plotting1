# Load data into R for dates from 2007-02-01 to 2007-02-02.
fname <- paste(getwd(), "household_power_consumption.txt", sep="/") 
pwrdf <- read.table(fname, sep=";", col.names = c("Date", "Time", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering1", "SubMetering2", "SubMetering3"), na.strings="?", skip = grep("1/2/2007", readLines(fnam)), nrows=2880)

# Create & open a png file.
png(paste(getwd(), "plot1.png", sep="/"), width=480, height=480)

# Plot histogram of Global Active Power
#dev.new(width=480, height=480, unit="px")
hist(pwrdf$GlobalActivePower, col="red", main="Global Active Power", xlab="Global active power (kilowatts)",ylim=c(0,1200))

# Close png file.
dev.off()