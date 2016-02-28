#read all data
power_consumption <- read.table(file = "./exdata-data-household_power_consumption/household_power_consumption.txt", sep=";", header = TRUE, dec=".", stringsAsFactors = FALSE)

#using lubridate package to parse date and time
library(lubridate)
power_consumption$Date <- dmy(power_consumption$Date)


#subset only 2 required dates
power_consumption_dates <- subset(power_consumption,Date >= "2007-02-01" & Date < "2007-02-03")

power_consumption_dates$Date_Time <- as.POSIXct(paste(power_consumption_dates$Date, power_consumption_dates$Time), format="%Y-%m-%d %H:%M:%S")

#transform Global active power to numeric
power_consumption_dates$Global_active_power <- as.numeric(power_consumption_dates$Global_active_power)

#remove all data from memory
rm(power_consumption)

#draw plot
with(power_consumption_dates,plot(x=Date_Time, y=Global_active_power, type = "l", ylab="Global active power (kilowatts)", xlab=""))

#save plot
dev.copy(png, file ="plot2.png")
dev.off()