## load library
## for data loading
library(data.table)
## for chaining
library(dplyr)

## load the data
dat <- fread("household_power_consumption.txt")
dat_tbl <- tbl_df(dat)

## transform Date as character to date format, same for time
   
dat_tbl <- mutate(dat_tbl,AsDate=as.Date(Date,format = "%d/%m/%Y"))
DateOfInterest <- c(as.Date("1/2/2007",format="%d/%m/%Y"),as.Date("2/2/2007",format="%d/%m/%Y"))
sample <- filter(dat_tbl, dat_tbl$AsDate %in% DateOfInterest)
rm("dat","dat_tbl")
GAP <- as.numeric(sample$Global_active_power)
sample <- mutate(sample,DateTime=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))



## create graph
## define png as device and png plot size
png("Plot4.png",width=480,height = 480)
par(mfrow = c(2,2))
## plot histogram with red color and title addition
plot(sample$DateTime,sample$Global_active_power,type='l',ylab = "Global Active Power",xlab="")
plot(sample$DateTime,sample$Voltage,type='l',ylab = "Voltage",xlab="datetime")
plot(sample$DateTime,sample$Sub_metering_1,type='l',col = "black",ylab = "Energy sub metering",xlab="")
lines(sample$DateTime,sample$Sub_metering_2,type='l',col = "red")
lines(sample$DateTime,sample$Sub_metering_3,type='l',col = "blue")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),col=c("black", "red", "blue"),lty =c(1,1,1),bty="n")
plot(sample$DateTime,sample$Global_reactive_power,type='l',ylab = "Global_Reactive_Power",xlab="datetime")

## close png as device
dev.off()