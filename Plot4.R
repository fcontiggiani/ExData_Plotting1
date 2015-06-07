### My mother tongue is spanish, so if you feel my comments are written in a strange way, consider that my redaction in english maybe is not quiet good ###
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" ### Setting the source for the data file from the web
temp <- tempfile()
download.file(fileUrl, temp) ### In case you work under Mac OS, you should try >- download.file(fileUrl, temp, method = "curl")
							 ### Creates the temporary file that wil be unzipped
date.download <- system.time ### Register the time of download
data.hpc <- data.frame(read.csv(unzip(temp), sep=";", na.strings=c("NA", "?"))) ### Read and tide the data
unlink(temp)

data.hpc$Date <- as.Date(data.hpc$Date, format="%d/%m/%Y") ### Convert the date data to the date format
data <- subset(data.hpc, subset=(Date >= "2007-02-01" & Date <= "2007-02-02")) ## Subsetting the data
rm(data.hpc)


datetime <- paste(as.Date(data$Date), data$Time) ## Converting dates
data$Datetime <- as.POSIXct(datetime)



par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
    plot(Global_active_power~Datetime, type="l", 
         ylab="Global Active Power", xlab="")
    plot(Voltage~Datetime, type="l", 
         ylab="Voltage", xlab="datetime")
    plot(Sub_metering_1~Datetime, type="l", 
         ylab="Energy sub meterin", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Datetime, type="l", 
         ylab="Global Rective Power",xlab="datetime")
}) ## Plot 4.

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off() ## Saving to file
