setwd("~/R")
##
###
### Read and subset household power comsumption dataset
### so that we are working only with data from 2/1/2007 and 2/2/2007
###
##
pwrfull <- read.table("household_power_consumption.txt", na.strings="?", header=T, sep=";")
pwr <- pwrfull[pwrfull$Date == "1/2/2007" | pwrfull$Date == "2/2/2007", ]
##
pwr <- within(pwr, {  ## Add a POSIXlt datetime value corresponding to Date and Time combined
  DateTime <- strptime(paste(Date, Time, sep=" "), format = "%d/%m/%Y %H:%M:%S") 
})
##
par(mfcol=c(2,2), ps=10) ## Set up for 2-column, 2-row plot and set font size
##
### Plot graph 1
##
plot(pwr$DateTime, pwr$Global_active_power, type="l", ylab="Global Active Power", xlab = "")
##
### Plot graph 2
##
with(pwr,
     {
       plot(DateTime, Sub_metering_1, col="black", type="l", xlab="", 
            ylab="Energy sub metering")   
       lines(DateTime, Sub_metering_2, col="red")   
       lines(DateTime, Sub_metering_3, col="blue")
       legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
              lty=c(1,1,1), col=c("black", "red", "blue"), bty="n")
     }
) 
##
### Plot graph 3
##
plot(pwr$DateTime, pwr$Voltage, type="l", ylab="Voltage", xlab = "datetime")
##
### Plot graph 4
##
plot(pwr$DateTime, pwr$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab = "datetime")
##
### Write 4-graph screen plot to a .png file
##
dev.copy(png, width=480, height=480, file="plot4.png")
dev.off()
