setwd("C:/Users/Brad/Documents/coursera data science/Getting and Cleaning Data/Week_4")

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip to ./data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Read in tables:
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

#Assign Column Names
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"
colnames(x_test) <- features[,2]
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
colnames(activity_labels) <-c("activityId", "activityType")

# Merging datasets
merge_train <- cbind(subject_train,x_train,y_train)
merge_test <- cbind(subject_test,x_test,y_test)
setAllInOne <- rbind(merge_train,merge_test)

# Create vetor of Column Names for reference
colNames <- colnames(setAllInOne)

# add mean and stdev 
mean_and_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)
setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]

# create dataset with descriptive activity names
setWithActivityNames <- merge(setForMeanAndStd, activity_labels,by = 'activityId',all.x=TRUE)

# create a second dataset with the average of each variable for each activity and each subject
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames,mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
write.csv(secTidySet, "secTidySet.csv")

