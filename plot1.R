
#read all data
power_consumption <- read.table(file = "./exdata-data-household_power_consumption/household_power_consumption.txt", sep=";", header = TRUE, dec=".", stringsAsFactors = FALSE)

#using lubridate package to parse date and time
library(lubridate)
power_consumption$Date <- dmy(power_consumption$Date)

#subset only 2 required dates
power_consumption_dates <- subset(power_consumption,Date >= "2007-02-01" & Date < "2007-02-03")
#remove all data from memory
rm(power_consumption)
#transform Global active power to numeric
power_consumption_dates$Global_active_power <- as.numeric(power_consumption_dates$Global_active_power)
#draw histogram
hist(x = power_consumption_dates$Global_active_power, xlab="Global active power (kilowatts)", ylab = "Frequency", col="red", main="Global active power")
#save as png
dev.copy(png, file="plot1.png")
dev.off()