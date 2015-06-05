# requires dplyr and lubridate packages
path.expand("~/")
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "~/zip.zip") #reads the zipfile into the WD from the web-source
unzip("zip.zip") #unzips data into the WD
table<-read.table("household_power_consumption.txt", sep=";", header = TRUE) #imports data into R
library(dplyr)
tbl<-tbl_df(table)
rm(table) #removes unneeded data from memory
library(lubridate)
data<-filter(tbl, dmy(Date) == dmy("01/02/2007") | dmy(Date) == dmy("02/02/2007")) 
#now data is the dataset nessesary for the further steps
rm(tbl) #removes unneeded data from memory
#The lines above are shared by the all of four plot_.R files
Sys.setlocale("LC_TIME", "eng")
D_T<-paste(as.vector(data$Date), as.vector(data$Time))
D_T<-gsub("2/2/2007", "2007-02-02", D_T)
D_T<-gsub("1/2/2007", "2007-02-01", D_T)
datetime<- parse_date_time(D_T,"%Y%m%d %H%M%S") #x-axis
#(1, 1)-plot y-axis
gap<-as.numeric(as.vector(data$Global_active_power))
#(1,2)-plot y-axis
V<-as.numeric(as.vector(data$Voltage))
#(2, 1)-plot y-axis
sm1<-as.numeric(as.vector(data$Sub_metering_1))
sm2<-as.numeric(as.vector(data$Sub_metering_2))
sm3<-as.numeric(as.vector(data$Sub_metering_3))
#(2, 2)-plot y-axis
Global_reactive_power<-as.numeric(as.vector(data$Global_reactive_power))

png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
#plotting (1, 1)
plot(datetime, gap, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
#plotting (1, 2)
plot(datetime, V, type="l", ylab="Voltage")
#plotting (2, 1)
plot(datetime, sm1, type="l", col="black", 
     xlab = "", ylab = "Energy sub metering")
lines(datetime, sm2, type="l", col="red")
lines(datetime, sm3, type="l", col="blue")
legend("topright", col = c("black", "red","blue"), 
       lty = c(1,1,1),
       legend = c("Sub_metering_1", "Sub_metering_1", "Sub_metering_3"))
#plotting (2, 2)
plot(datetime, Global_reactive_power, type="l")
dev.off()