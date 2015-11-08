## Exploritory Data: Project 1 ##
  
## Data Set location ##
setwd("C:/RLearning/Coursera/ExploritoryDataAnalysis/Project1/exdata_data_household_power_consumption")

## If not pre-existing ##
## install.packages("dplyr")
library(dplyr)

## Read file as a data frame ##
ds <- as.data.frame(read.table("household_power_consumption.txt", sep=";", header=TRUE))


## Get rows for the 1st and 2nd of Feb. 2007 ##
ds1 <- filter(ds, Date == "1/2/2007")
ds2 <- filter(ds, Date == "2/2/2007")
rs <- rbind(ds1, ds2)

## Format values as Numeric data type ##
### rs <- mutate(rs, Date = as.Date(Date,"%d%m%y")) -- Not working
rs <- mutate(rs, Time = substr(as.character(Time),1,8))
rs <- mutate(rs, Voltage = as.numeric(as.character(rs$Voltage)))
rs <- mutate(rs, Global_active_power = as.numeric(as.character(rs$Global_active_power)))
rs <- mutate(rs, Global_reactive_power = as.numeric(as.character(rs$Global_reactive_power)))
rs <- mutate(rs, Global_intensity = as.numeric(as.character(rs$Global_intensity)))
rs <- mutate(rs, Sub_metering_1 = as.numeric(as.character(rs$Sub_metering_1)))
rs <- mutate(rs, Sub_metering_2 = as.numeric(as.character(rs$Sub_metering_2)))
rs <- mutate(rs, Sub_metering_3 = as.numeric(as.character(rs$Sub_metering_3)))

## Format data for analysis ##
rs <- mutate(rs, Global_active_power_kWH = round(Global_active_power,0))
rs <- mutate(rs, Day = substr(as.character(Date),1,1))
rs <- mutate(rs, TimeHr = substr(as.character(Time),1,2))
rs <- mutate(rs, TimeMin = substr(as.character(Time),4,5))

rs <- mutate(rs, Time2 = paste(Day, TimeHr, TimeMin, sep = ""))



## Plot Data ##

## Change working directory to output graphics ##
setwd("C:/RLearning/Coursera/ExploritoryDataAnalysis/Project1")


## Open PNG device
png(file = "plot2.png")

## Create plot and send to a file
with(rs, plot(rs$Time2, rs$Global_active_power, type = "l", ylab = "Global active power (kWH)", xlab = "Date/Time"))

## Close the PNG file device
dev.off()
