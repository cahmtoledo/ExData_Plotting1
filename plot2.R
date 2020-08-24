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


png(filename = "plot2.PNG")
plot(tidydf$Time, tidydf$Global_active_power, type = 'n', xlab ="", 
     ylab = "Global Active Power (kilowatts)")
lines(tidydf$Time, tidydf$Global_active_power)
dev.off()
