
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

#Convert Date/Time columns to R Dates/R Times
household_dataset$Date <- as.Date(household_dataset$Date, format="%d/%m/%Y")

#Subset relevant timeframe
first_day <- subset(household_dataset, Date==as.Date("2007/2/1"))
second_day <- subset(household_dataset, Date==as.Date("2007/2/2"))
powerconsumption <- rbind(first_day, second_day)

#Add Datetime column for plotting 
powerconsumption$DateTime <- strptime(with(powerconsumption,paste(Date,Time)),
                                      format = "%Y-%m-%d %H:%M:%S")
#Open graphic device 
png("plot3.png", width = 480, height = 480)
#Create blank plot with annotations 
with( powerconsumption, plot(DateTime,Sub_metering_1, type="n", 
                             ylab = "Energy sub metering", xlab=""))
#Add lines/data to the plot 
with(powerconsumption, lines(DateTime, Sub_metering_1))
with(powerconsumption, lines(DateTime, Sub_metering_2, col="red"))
with(powerconsumption, lines(DateTime, Sub_metering_3, col="blue"))
#Add legend to the plot
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black","red", "blue"), lty=c(1,1,1))

dev.off()

