#Constructing data
library(data.table)
library(dplyr)
library(plyr)
dfcolclasses = c(rep("character", 2), rep("numeric", 7))
df <- fread("household_power_consumption.txt", sep = ';', header = T,
            colClasses = c(rep("character", 9)))


df$Date <- as.Date(df$Date, format="%d/%m/%Y")


df <- df %>% filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))



Time <- as.POSIXct(paste(df$Date, df$Time), format = "%Y-%m-%d %H:%M:%S")
df$Time <- Time

tidydf
tidydf<- df[,1:2]
tidydf<- cbind(tidydf,as.data.frame(sapply(df[,3:9], as.numeric)))


png(filename = "plot4.PNG")
par(mfcol = c(2,2))
#Graph 1
plot(tidydf$Time, tidydf$Global_active_power, type = 'n', xlab ="", 
     ylab = "Global Active Power (kilowatts)")
lines(tidydf$Time, tidydf$Global_active_power)
#Graph 2
plot(tidydf$Time, tidydf$Sub_metering_1, type = 'n', xlab ="", 
     ylab = "Energy sub metering")
lines(tidydf$Time, tidydf$Sub_metering_1)
lines(tidydf$Time, tidydf$Sub_metering_2, col='red')
lines(tidydf$Time, tidydf$Sub_metering_3, col='blue')
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c('black','blue','red'), lty = c(1,1,1))
#Graph 3
plot(tidydf$Time, tidydf$Voltage, type = 'n', xlab ="datetime", 
     ylab = "Voltage")
lines(tidydf$Time, tidydf$Voltage)
#Graph 4
plot(tidydf$Time, tidydf$Global_reactive_power, type = 'n', xlab ="datetime")
lines(tidydf$Time, tidydf$Global_reactive_power)
dev.off()
