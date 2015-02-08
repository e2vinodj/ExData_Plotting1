# Read the "Individual household electric power consumption Data Set" and Plot graphs
# Make Multiple graphs (four blocks) in one page and save as PNG File (plot4.png).
# In Quadrant-1 - Plot Timeseries graph for Global_active_power for the Period  02/01/2007 to 02/02/2007
# In Quadrant-2 - Plot Timeseries graph for Voltage for the Period  02/01/2007 to 02/02/2007
# In Quadrant-3 - Plot Timeseries graph for Sub_metering_1, Sub_metering_2, Sub_metering_3 for the Period  02/01/2007 to 02/02/2007
# In Quadrant-4 - Plot Timeseries graph for Global_reactive_power for the Period  02/01/2007 to 02/02/2007

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

#### Plot4
# Save the Plot of multiple time series lines to the PNG file (plot4.png). Default is 480X480 

png("plot4.png")

# Draw multiple plots 2X2 = 4 Plots, in one Image
par(mfrow=c(2,2))

# Draw Plot-2 in Quadrant-1

Date.Time <-tblhpwrSelect$Date.Time
Global_active_power <-as.numeric(tblhpwrSelect$Global_active_power)

plot(Date.Time,Global_active_power,"l", xlab="", ylab="Global Active Power")

# Draw plot in Quadrant-2

Voltage <-as.numeric(tblhpwrSelect$Voltage)
plot(Date.Time,Voltage,"l", xlab="datetime", ylab= "Voltage")

# Draw Plot-3 in Quadrant-3

Sub_metering_1 <-as.numeric(tblhpwrSelect$Sub_metering_1)
Sub_metering_2 <-as.numeric(tblhpwrSelect$Sub_metering_2)
Sub_metering_3 <-as.numeric(tblhpwrSelect$Sub_metering_3)
Range_Sub_meter <- c(Sub_metering_1, Sub_metering_2, Sub_metering_3)

plot(Date.Time,Sub_metering_1,"l", ylim=range(Range_Sub_meter ),col="black", axes = TRUE, xlab="", ylab="Energy sub metering")
lines(Date.Time,Sub_metering_2,"l", ylim=range(Range_Sub_meter ),col="red")
lines(Date.Time,Sub_metering_3,"l", ylim=range(Range_Sub_meter ),col="blue")
# Add the legends on the top right of the Plot
legend("topright", lty=1 ,col=c("black","red","blue"), bty = "n",legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3") )

# Draw plot in Quadrant-4

Global_reactive_power <-as.numeric(tblhpwrSelect$Global_reactive_power)
plot(Date.Time,Global_reactive_power,"l", xlab="datetime", ylab= "Global_reactive_power",  yaxt="n")
axis( 2, cex.axis=0.7, tck=-.05)

dev.off()
