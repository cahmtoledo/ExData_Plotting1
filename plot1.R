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



png(filename = "plot1.PNG")
hist(x = tidydf$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col='red',
     main = "Global Active Power")
dev.off()

