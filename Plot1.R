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



## create graph
## define png as device and png plot size
png("Plot1.png",width=480,height = 480)
## plot histogram with red color and title addition
hist(GAP,col="red",xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power")
## close png as device
dev.off()