# Read the "Individual household electric power consumption Data Set" and Plot graphs
# Make Timeseries graph for Sub_metering_1, Sub_metering_2, Sub_metering_3 for the Period  02/01/2007 to 02/02/2007
# Save the graph as plot3.png file

#Create a Folder to Save the data File (if not already present)
fldr <- "mydata"
if (!file.exists(fldr)) {
  dir.create(fldr, showWarnings = TRUE, recursive = FALSE) }

# DownLoad the File if it does not already exist in the Local Working Directory- Sub folder mydata

localfile <- "mydata/household_power_consumption.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download the zip file to the local data folder. Only if it does not exist
if (!file.exists(localfile)) {
  setInternet2(TRUE)
  download.file(fileURL ,localfile,method="auto") }

## Read the household consumption data from the Text file (archived-zip).
tblhpwr <- read.table(unz(localfile, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "NA", stringsAsFactors=F, dec = ".", colClasses = NA)

# Convert the Date and Time character columns into a Date Column 
tblhpwr$Date.Time <- strptime(paste(tblhpwr$Date,tblhpwr$Time),"%d/%m/%Y %H:%M:%S")

# Subset the Electric Consumption Data for only Dates 02/01/2007 & 02/02/2007
tblhpwrSelect <- subset(tblhpwr, as.Date(Date.Time) >= "2007-02-01" & as.Date(Date.Time) <= "2007-02-02" )

# To Draw Plot-3 into a PNG File

# Plot3

Sub_metering_1 <-as.numeric(tblhpwrSelect$Sub_metering_1)
Sub_metering_2 <-as.numeric(tblhpwrSelect$Sub_metering_2)
Sub_metering_3 <-as.numeric(tblhpwrSelect$Sub_metering_3)
Range_Sub_meter <- c(Sub_metering_1, Sub_metering_2, Sub_metering_3)


# Save the Plot of multiple time series lines to the PNG file (plot3.png). Default is 480X480 

png("plot3.png")
plot(Date.Time,Sub_metering_1,"l", ylim=range(Range_Sub_meter ),col="black", axes = TRUE, xlab="", ylab="Energy sub metering")
lines(Date.Time,Sub_metering_2,"l", ylim=range(Range_Sub_meter ),col="red")
lines(Date.Time,Sub_metering_3,"l", ylim=range(Range_Sub_meter ),col="blue")
# Add the legends on the top right of the Plot
legend("topright", lty=1 ,col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3") )

dev.off()
