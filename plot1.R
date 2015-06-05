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
#now data is the dataset necessary for the further steps
rm(tbl) #removes unneeded data from memory
#The lines above are shared by the all four code_.R files

Gap<-as.numeric(as.vector(data$Global_active_power))
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(Gap, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()