####################################################################################################################
# Script Name: Plot3.R                                                                                             #
# Date: August 8, 2015                                                                                             #
# Course: exdata-031                                                                                               #
# Description: This script examines how a household energy usage over a 2-day period in February, 2007.            #  
#              Plot1.R script downloads and extract the data, trim the data for just two days, then generates      #
#              the 3 energy submetering plot and saves it in a png format. Plot requires dplyr package installed   #         
#                                                                                                                  #
####################################################################################################################

setwd("~/DataScience/ExplorData/proj1") # set working direcotry

#download data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/powercomsumption.zip", method = "curl")

unzip("./data/powercomsumption.zip") # unzip the downloaded file

#store the data in the working directory
household_power_consumption <- read.csv("~/DataScience/ExplorData/household_power_consumption.txt", sep=";", na.strings="?", stringsAsFactors=FALSE)

df3 <- household_power_consumption #copy of the working directory 
df3$Date <- as.Date(df3$Date, format = "%d/%m/%Y") #convert the class for the date from char to Date
df3 <- df3[with(df3, df3$Date == "2007-02-01" | df3$Date == "2007-02-02"),] #extract data only for the two days in Feb 2007
df3 <- df3 %>% mutate(date = paste(df3$Date, df3$Time)) #Using the dplyr pkg, merge date/time 
df3 = df3[,c(10,3,4,5,6,7,8,9,1,2)] #reorder the column for redability
df3$date <- as.POSIXct(df3$date) #convert the new column from class char to POSIXct

#plot the three energy sub metering for the two days
with(df3, plot(df3$date, df3$Sub_metering_1, type = "l",
              ylab = "Energy Sub Metering", 
              xlab = ""
))

lines(df3$date, df3$Sub_metering_2, col = "red", type = "l") #the plot for sub metering 2
lines(df3$date, df3$Sub_metering_3, col = "blue", type = "l") #the plot for sub metering 3
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex =0.5) #create a legend and color them apart

dev.copy(png, file = "plot3.png", width = 480, height = 480) #saves file in png for mat with 480x480 pixle
dev.off() #exit the file device.