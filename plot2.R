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
par(mar=c(5.1, 5.1, 4.1, 2.1), ps=10) ## Expand left margin by an inch, set text font size
##
###
### Plot graph 2 and create corresponding .png graphics file
###
##
plot(pwr$DateTime, pwr$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab = "")
dev.copy(png, width=480, height=480, file="plot2.png")
dev.off()
