plot1 <- function() {
  # Read header row from original file into a file
  system2("head", "-1 household_power_consumption.txt", stdout="f1.txt")
  # Look for the required dates data in the large file and store in another file
  system2("grep", "-E '^1/2/2007|^2/2/2007' household_power_consumption.txt", stdout="f2.txt")
  # Create new file with the header row available and data for 1 and 2 Feb 2007
  system2("cat", "f1.txt f2.txt", stdout="house.txt")
  # Enough computer memory available, read the subset file
  colC=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
  raw_data <- read.table(file="house.txt", header=TRUE, sep = ";", na.strings="?",colClasses=colC)
  # remove the temporary files
  system2("rm", "f1.txt f2.txt house.txt")
  # Convert Date and Time format from character to Date formats
  all_data <- data.frame(Date=strptime(raw_data$Date, "%d/%m/%Y"), 
                         Time=strptime(raw_data$Time, "%H:%M:%S"),
                         Global_active_power=raw_data$Global_active_power,
                         Global_reactive_power=raw_data$Global_reactive_power,
                         Voltage=raw_data$Voltage,
                         Global_intensity=raw_data$Global_intensity,
                         Sub_metering_1=raw_data$Sub_metering_1,
                         Sub_metering_2=raw_data$Sub_metering_2,
                         Sub_metering_3=raw_data$Sub_metering_3)
  # Run the plot1
  png(filename="plot1.png", width=480, height=480, units="px")
  hist(all_data$Global_active_power, col="azure", 
       main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
  z<-dev.off()
}

