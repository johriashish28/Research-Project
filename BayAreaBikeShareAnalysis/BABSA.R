#Analysis of Bay Area Bike Sharing

#set working Directory
setwd("C:/Users/S.K/Desktop/Bay_Area_BIke_Share_Analysis")

#get data set for Analysis
Dataset1 = read.csv('Data/201402_trip_data.csv')
Dataset2 = read.csv('Data/201408_trip_data.csv')
Dataset3 = read.csv('Data/201508_trip_data.csv')

#Rename variable name, to make all 3 files with identical column names
names(Dataset1)[names(Dataset1) == "Subscription.Type"] <- "Subscriber.Type"

#Merge all 3 data files into one file
Dataset = rbind(Dataset1, Dataset2, Dataset3)

#to check first 50 records in the data file
head(Dataset, n=50)


#install package to convert datetime variable into different variables
#install.packages('dplyr')
library(dplyr)

Hours <- format(as.POSIXct(strptime(Dataset$Start.Date, "%m/%d/%Y %H:%M", tz = "")), format = "%H:%M")
Year <- format(as.POSIXct(strptime(Dataset$Start.Date, "%m/%d/%Y %H:%M", tz = "")), format = "%Y")
Month <- format(as.POSIXct(strptime(Dataset$Start.Date, "%m/%d/%Y %H:%M", tz = "")), format = "%m")
Day <- format(as.POSIXct(strptime(Dataset$Start.Date, "%m/%d/%Y %H:%M", tz = "")), format = "%a")

Dataset$Hours <- Hours
Dataset$Year <- Year
Dataset$Month <- Month
Dataset$Day <- Day

#insert City name from Station Data info

Stndata = read.csv('Data/201508_station_data.csv')

Dataset$name <- Dataset$Start.Station

X = left_join(Dataset, Stndata, by = "name")

FinalData <- X[1:22]

write.csv2(FinalData, file = "Data.csv", row.names = FALSE)

