####################################################################################################################
# Script Name: plot1.R                                                                                              #
# Date: August 8, 2015                                                                                             #
# Course: exdata-031                                                                                               #
# Description: This script examines how a household energy usage over a 2-day period in February, 2007.            #  
#              Plot1.R script downloads and extract the data, trim the data for just two days, then generates      #
#              a histogram plot and saves it in a png format.                                                      #         
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


df1 <- household_power_consumption #copy of the working directory 
df1$Date <- as.Date(df1$Date, format = "%d/%m/%Y") #convert the class for the date from char to Date
df1 <- df1[with(df1, df1$Date == "2007-02-01" | df1$Date == "2007-02-02"),] #extract data only for the two days in Feb 2007
df1 <- df1 %>% mutate(date = paste(df1$Date, df1$Time)) #Using the dplyr pkg, merge date/time 
df1 = df1[,c(10,3,4,5,6,7,8,9,1,2)] #reorder the column for redability
df1$date <- as.POSIXct(df1$date) #convert the new column from class char to POSIXct

#Plot a histogram for the two days Active power usage
with(df1, hist(df1$Global_active_power, 
               xlab = "Gloabl Active Power (kilowatts)", 
               col = "red", 
               main = "Global Active Power"))

dev.copy(png, file = "plot1.png", width = 480, height = 480) #saves the plot in png format with 480x480 pixle
dev.off() # close the file device

