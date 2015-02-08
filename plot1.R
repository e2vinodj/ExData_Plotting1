# Read the "Individual household electric power consumption Data Set" and Plot graphs

#Create a Folder to Save the data File (if not already present)
fldr <- "mydata"
if (!file.exists(fldr)) {
  dir.create(fldr, showWarnings = TRUE, recursive = FALSE) }

# DownLoad the File if it does not already exist in the Local Working Directory- Sub folder mydata
# Make Histogram (Frequency) of Global_active_power for the Period  02/01/2007 to 02/02/2007
# Save the graph as plot1.png file

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

# Draw Plot-1 into a PNG File

# Save the histogram to the PNG file (plot2.png). Default is 480X480 

png("plot1.png")
hist(as.numeric(tblhpwrSelect$Global_active_power), xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
dev.off()



