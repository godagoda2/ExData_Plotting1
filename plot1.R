plot1 <- function(){
  
  tmp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",tmp)
  tmpf <- unzip(tmp)
  
  data <- read.table(tmpf[1],header = TRUE, sep=";")
  
  unlink(tmp)
  unlink(tmpf)
  rm(tmp)
  rm(tmpf)
  
  data <- transform(data,
                    Date=as.Date(Date,format="%d/%m/%Y"),
                    Global_active_power=as.numeric(Global_active_power),
                    Global_reactive_power=as.numeric(Global_reactive_power),
                    Voltage=as.numeric(Voltage),
                    Global_intensity=as.numeric(Global_intensity),
                    Sub_metering_1=as.numeric(Sub_metering_1),
                    Sub_metering_2=as.numeric(Sub_metering_2),
                    Sub_metering_3=as.numeric(Sub_metering_3)
                    )
  
  data2<- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]
  
  #print(head(data,10))
  #unlink(data)
  #rm(data)
  
  print("outout start")
  
  png(filename ="plot1.png", type = "windows")
  hist(data2$Global_active_power,col = "red",main="Global Active Power",xlab = "Global Active Power")
  dev.off()
  
  print("output finished")
  
}