plot3 <- function(){
    
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
    
## lets make time easier (ha!)
pd_sel$POSIX_time <- paste(pd_sel[,1], pd_sel[,2])
pd_sel$POSIX_time <- strptime(pd_sel$POSIX_time, format = "%Y-%m-%d %H:%M:%S",
                                  tz = "Europe/Paris")
    
pd_sel$Sub_metering_1 <- as.numeric(pd_sel$Sub_metering_1)
pd_sel$Sub_metering_2 <- as.numeric(pd_sel$Sub_metering_2)
xlabels <- as.POSIXct(c("2007-02-01 00:05", "2007-02-02 00:00", 
                        "2007-02-02 23:55"), format =  "%Y-%m-%d %H:%M",
                      tz="Europe/Paris")

png(filename = "plot3.png")

## suppress the default x-axis labeling 
with(pd_sel, plot(POSIX_time, Sub_metering_1, type = "l", xlab = "",
                  xaxt = "n", ylab = "Energy sub metering"))

## add some additional lines
lines(pd_sel$POSIX_time, pd_sel$Sub_metering_2, col = "red")
lines(pd_sel$POSIX_time, pd_sel$Sub_metering_3, col = "blue")
legend("topright",
   legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
   lwd =2, lty = 1,
   col = c("black", "red", "blue"))

axis.POSIXct(side = 1, at = xlabels, labels = c("Thu", "Fri", "Sat"))

dev.off()

print("You just PNG'ed! Check your working directory for 'plot3.png'")  
}