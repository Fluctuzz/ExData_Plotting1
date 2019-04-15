
#Download dataset if it isn't in the working directory
if(!file.exists("household_power_consumption.txt")){
    download.file(
        url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
        dest="rprog_data_specdata.zip")
    unzip("rprog_data_specdata.zip")
}

#Read in dataset 
household_dataset <- read.table("household_power_consumption.txt", 
                                sep= ";", na.strings = "?", header=TRUE)

#Convert Date columns to R Dates
household_dataset$Date <- as.Date(household_dataset$Date, format="%d/%m/%Y")

#Subset relevant timeframe
first_day <- subset(household_dataset, Date==as.Date("2007/2/1"))
second_day <- subset(household_dataset, Date==as.Date("2007/2/2"))
powerconsumption <- rbind(first_day, second_day)

#Open graphic device
png("plot1.png", width = 480, height = 480)
#Create plot
hist(powerconsumption$Global_active_power, col="red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()
