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
names(pw_cons) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## Generating the PNG
png(filename = "./images/plot1.png",width = 480, height = 480, units = "px")
hist(pw_cons$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main="Global Active Power")
dev.off()