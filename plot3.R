#read all data
power_consumption <- read.table(file = "./exdata-data-household_power_consumption/household_power_consumption.txt", sep=";", header = TRUE, dec=".", stringsAsFactors = FALSE)

#using lubridate package to parse date and time
library(lubridate)
power_consumption$Date <- dmy(power_consumption$Date)

#subset only 2 required dates
power_consumption_dates <- subset(power_consumption,Date >= "2007-02-01" & Date < "2007-02-03")

#remove all data from memory
rm(power_consumption)

#merge date and time columns
power_consumption_dates$Date_Time <- as.POSIXct(paste(power_consumption_dates$Date, power_consumption_dates$Time), format="%Y-%m-%d %H:%M:%S")

#transform to numeric
power_consumption_dates$Sub_metering_1 <- as.numeric(power_consumption_dates$Sub_metering_1)
power_consumption_dates$Sub_metering_2 <- as.numeric(power_consumption_dates$Sub_metering_2)

#draw plot
with(power_consumption_dates, plot(Date_Time,Sub_metering_1,type = "n", xlab="", ylab="Energy sub metering"))
with(power_consumption_dates, lines( x=Date_Time, y=Sub_metering_1))
with(power_consumption_dates, lines( x=Date_Time, y=Sub_metering_2, col="red"))
with(power_consumption_dates, lines( x=Date_Time, y=Sub_metering_3, col="blue"))
legend("topright", lty=1,col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ))

#save plot
dev.copy(png, file ="plot3.png")
dev.off()