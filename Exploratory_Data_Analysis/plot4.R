library(data.table)
library(dplyr)
x <- read.csv("household_power_consumption.txt",sep=";",na.strings=c("?"))
dt <- data.table(x,key="Date")
dt <- filter(dt,Date %in% c("1/2/2007","2/2/2007"))
y <- as.POSIXct(strptime(paste0(dt$Date,"/",dt$Time),"%d/%m/%Y/%H:%M:%S"))
dt[,tim:=y]
par(mfrow=c(2,2), mar=c(5,4,2,2), oma=c(0,0,2,0))
with(dt, {
  plot(tim,Global_active_power,xlab="",ylab="Global active power",type="l")
  
  plot(tim,Voltage,type="l",xlab="datetime")
  
  plot(tim,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
  lines(tim,Sub_metering_2,col="red")
  lines(tim,Sub_metering_3,col="blue")
  legend("topright", col=c("black", "red", "blue"),lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(tim,Global_reactive_power,xlab="datetime",type="l")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
