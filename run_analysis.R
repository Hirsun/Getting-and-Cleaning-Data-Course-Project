# Initialize
if(!file.exists("./data")) {dir.create("./data")}

# Download and unzip dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFile <- "./data/Dataset.zip"
download.file(fileUrl, destfile = destFile)
unzip(zipfile = destFile, exdir = "./data")

# File paths
filePaths <- list(
  "train/X_train.txt",
  "train/y_train.txt",
  "train/subject_train.txt",
  "test/X_test.txt",
  "test/y_test.txt",
  "test/subject_test.txt",
  "features.txt",
  "activity_labels.txt"
)

# Read data
readData <- function(filePath) { 
  read.table(paste("./data/UCI HAR Dataset", filePath, sep = "/"))
}

x_train <- readData(filePaths[1])
y_train <- readData(filePaths[2])
subject_train <- readData(filePaths[3])

x_test <- readData(filePaths[4])
y_test <- readData(filePaths[5])
subject_test <- readData(filePaths[6])

features <- readData(filePaths[7])
activityLabels <- readData(filePaths[8])

# Rename columns
colNames <- list("activityId", "subjectId", features[,2])
renameColumns <- function(data, name) {
  colnames(data) <- name
  return(data)
}

x_train <- renameColumns(x_train, colNames[3])
y_train <- renameColumns(y_train, colNames[1])
subject_train <- renameColumns(subject_train, colNames[2])

x_test <- renameColumns(x_test, colNames[3])
y_test <- renameColumns(y_test, colNames[1])
subject_test <- renameColumns(subject_test, colNames[2])

activityLabels <- renameColumns(activityLabels, c('activityId','activityType'))

# Merge data
mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
setAllInOne <- rbind(mrg_train, mrg_test)

# Extract mean and std dev measurements
colNames <- colnames(setAllInOne)
mean_and_std <- grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames)
setForMeanAndStd <- setAllInOne[, mean_and_std == TRUE]

# Merge with activity labels
setWithActivityNames <- merge(setForMeanAndStd, activityLabels, by='activityId', all.x=TRUE)

# Create independent tidy data set
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

# Write to txt file
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
