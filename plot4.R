####################
# Loading the data #
####################
# To filter directly on the date, I first checked with the code
# which(pw_cons$Date=="1/2/2007" & pw_cons$Time=="00:00:00"),
# which(pw_cons$Date=="2/2/2007" & pw_cons$Time=="23:59:00"),
# where was situated the dates, then I scans according to those two values

pw_cons_filter <- scan("./data/household_power_consumption.txt", character(0), "\n", skip=66636, nlines=69516-66637+2)
new_file<-file("./data/household_power_consumption_filter.txt")
writeLines(pw_cons_filter, new_file)
close(new_file)

## Create a data frame
pw_cons <- read.csv("./data/household_power_consumption_filter.txt", sep=";")

# In this case, the Time column have to be converted as "Time" type
pw_cons$Date <- as.Date(pw_cons$Date, "%d/%m/%Y")
names(pw_cons) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Merging the date and time column to keep the chronological order
pw_cons <- data.frame(paste(pw_cons$Date, pw_cons$Time, sep=", "), pw_cons)
names(pw_cons) <- c("date_time", "Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
pw_cons$date_time <- strptime(pw_cons$date_time, format = "%d/%m/%Y, %H:%M:%S")



## Generating the PNG
png(filename = "./images/plot4.png",width = 480, height = 480, units = "px")
## Creation of the multiple base plots
par(mfrow = c(2,2), mar=c(4, 4, 2, 1))
with(pw_cons, {
  plot(date_time, Global_active_power,xlab="", ylab="Global Active Power", type="l")
  
  plot(date_time, Voltage,xlab="datetime", ylab="Voltage", type="l")
  
  plot(pw_cons$date_time, pw_cons$Sub_metering_1,type="l",col="black", xlab="", ylab="Energy sub metering")
  lines(pw_cons$date_time, pw_cons$Sub_metering_2,type="l",col="red")
  lines(pw_cons$date_time, pw_cons$Sub_metering_3,type="l",col="blue")
  legend("topright", lty=1, col= c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.col = "white",bty = "o", cex = 0.5, inset = c(0, 0), pt.cex = 0.6)
  plot(pw_cons$date_time, pw_cons$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power",type="l")
})
dev.off()