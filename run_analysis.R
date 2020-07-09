# Libraries
library(dplyr)

#Donwloading data for the project
dataname <- "Coursera_GettingCleaning.zip"
#If data is downloaded do nothing
if(!file.exists(dataname)){
      datalink <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(datalink, dataname, method = "curl")
}

#If folder exists do nothing
datafolder <- "UCI HAR Dataset"
if(!file.exists(datafolder)){
      unzip(dataname)
}

#Reading data 
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subTest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
xTest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
yTest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#1. Merging data
xData <- rbind(xTrain, xTest) #Merger of x_train.txt with x_test.txt
yData <- rbind(yTrain,yTest)  #Merger of y_train.txt with y_test.txt
subjectData <- rbind(subTrain,subTest) #Merger of subject_test.txt with subject_train.txt
mergerData <- cbind(subjectData, yData, xData) #Merger of all the data

#2. Extracting measurements on the mean and sd for measurements
extractData <- mergerData %>% select(subject,code, contains("mean"), contains("std")) #extract data from mergerData

#3. Using activity names to name the activities in the extract data (extractData)
extractData$code <- activities[extractData$code,2]

#4. Renaming the variables names
names(extractData)[2] = "activity"
names(extractData) <- gsub("Acc", "Accelerometer", names(extractData))
names(extractData) <- gsub("Gyro", "Gyroscope", names(extractData))
names(extractData) <- gsub("BodyBody", "Body", names(extractData))
names(extractData) <- gsub("Mag", "Magnitude", names(extractData))
names(extractData) <- gsub("^t", "Time", names(extractData))
names(extractData) <- gsub("^f", "Frequency", names(extractData))
names(extractData) <- gsub("tBody", "TimeBody", names(extractData))
names(extractData) <- gsub("-mean()", "Mean", names(extractData), ignore.case = TRUE)
names(extractData) <- gsub("-std()", "STD", names(extractData), ignore.case = TRUE)
names(extractData) <- gsub("-freq()", "Frequency", names(extractData), ignore.case = TRUE)
names(extractData) <- gsub("angle", "Angle", names(extractData))
names(extractData) <- gsub("gravity", "Gravity", names(extractData))

#5. Creating the tidy data
finalTidyData <- extractData %>% 
      group_by(subject, activity) %>%
      summarise_all(funs(mean))
write.table(finalTidyData,"TidyData.txt", row.name = FALSE)









