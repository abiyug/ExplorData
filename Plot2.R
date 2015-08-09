####################################################################################################################
# Script Name: plot2.R                                                                                             #
# Date: August 8, 2015                                                                                             #
# Course: exdata-031                                                                                               #
# Description: This script examines how a household energy usage over a 2-day period in February, 2007.            #  
#              Plot1.R script downloads and extract the data, trim the data for just two days, then generates      #
#              Global activity power plot and saves it in a png format. Plot requires dplyr package                #         
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

df2 <- household_power_consumption #copy of the working directory 
df2$Date <- as.Date(df2$Date, format = "%d/%m/%Y") #convert the class for the date from char to Date
df2 <- df2[with(df2, df2$Date == "2007-02-01" | df2$Date == "2007-02-02"),] #extract data only for the two days in Feb 2007
df2 <- df2 %>% mutate(date = paste(df2$Date, df2$Time)) #Using the dplyr pkg, merge date/time 
df2 = df2[,c(10,3,4,5,6,7,8,9,1,2)] #reorder the column for redability
df2$date <- as.POSIXct(df2$date) #convert the new column from class char to POSIXct

with(df2, plot(df2$date, df2$Global_active_power, type = "l",
              ylab = "Gloabl Active Power (kilowatts)", 
              xlab = ""
))
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()