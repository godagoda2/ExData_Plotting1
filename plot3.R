plot3 <- function(){
  
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
  dt <- paste(data2$Date,data2$Time)
  data3 <- cbind(data2,dt)
  data3 <- transform(data2,
                     dt=strptime(dt,format="%Y-%m-%d %H:%M:%S")
                     )
  
  #print(head(data,10))
  #unlink(data)
  #rm(data)
  library(datasets)
  print("outout start")
  
  png(filename ="plot3.png", type = "windows")
  with(data3,plot(dt,Sub_metering_1,col="black",type ="l",pch ="NA_integer_",xlab = "",ylab = "Energy of Sub Metering",ylim=c(0,40)))
  par(new=T)
  with(data3,plot(dt,Sub_metering_2,col="red",type ="l",pch ="NA_integer_",xlab = "",ylab = "",ylim=c(0,40)))
  par(new=T)
  with(data3,plot(dt,Sub_metering_3,col="blue",type ="l",pch ="NA_integer_",xlab = "",ylab = "",ylim=c(0,40)))
  legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty=c(1,1,1),pch=c(NA_integer_,NA_integer_,NA_integer_))
  
  dev.off()
  
  print("output finished")
  
}