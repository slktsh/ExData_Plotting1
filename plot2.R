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
#The lines above are shared by the all four plot_.R files
gap<-as.numeric(as.vector(data$Global_active_power))
D_T<-paste(as.vector(data$Date), as.vector(data$Time))
D_T<-gsub("2/2/2007", "2007-02-02", D_T)
D_T<-gsub("1/2/2007", "2007-02-01", D_T)
datetime<- parse_date_time(D_T,"%Y%m%d %H%M%S")
Sys.setlocale("LC_TIME", "eng")
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(datetime, gap, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()