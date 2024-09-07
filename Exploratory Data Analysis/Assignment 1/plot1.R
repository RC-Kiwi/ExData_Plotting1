plot1 <- function(){

## get data
    
if (!file.exists("household_power_consumption.txt")) {  
    wd <- getwd()
    fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = "./c4w1projdata.zip", method = "curl")
    zipF<- "./c4w1projdata.zip"
    unzip(zipF, exdir=wd)
    } 
pwr_dat <- read.table("./household_power_consumption.txt",header=TRUE, sep=";")

## lets work with less than 2 million rows

pwr_dat$Date <- as.Date(pwr_dat$Date, "%d/%m/%Y")
pd_sel <- subset(pwr_dat, pwr_dat$Date >= as.Date("2007-02-01"))
pd_sel <- subset(pd_sel, pd_sel$Date <= as.Date("2007-02-02"))

pd_sel$Global_active_power <- as.numeric(pd_sel$Global_active_power)

png(filename = "plot1.png")
hist(pd_sel$Global_active_power, breaks = 12, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
print("You just PNG'ed! Check your working directory for 'plot1.png'")
}