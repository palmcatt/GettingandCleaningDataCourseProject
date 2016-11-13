#########################################
# Check Library and download the datafile
#########################################

# Check library, install if missing
if (!require("reshape2")) {
  install.packages("reshape2")
}

library(reshape2)

# Download and unzip the data file
filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#################################################################################################
# Extracts only the measurements on the mean and standard deviation for each measurement. (req.2)
#################################################################################################

# Get all features
features <- read.table("UCI HAR Dataset/features.txt")

# Extracts only the measurements on the mean and standard deviation
featuresExtracted <- grep(".*mean.*|.*std.*", features[,2])
featuresExtracted.names <- features[featuresExtracted,2]

################################################################################
# Uses descriptive activity names to name the activities in the data set (req.3)
################################################################################

featuresExtracted.names <- gsub('-mean', 'Mean', featuresExtracted.names)
featuresExtracted.names <- gsub('-std',  'Std',  featuresExtracted.names)
featuresExtracted.names <- gsub('[-()]', '', featuresExtracted.names)

#######################################################################
# Merges the training and the test sets to create one data set. (req.1)
#######################################################################

# Load the datasets, only get the mean/standard deviation measures

trainMeasure <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresExtracted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects   <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainData       <- cbind(trainSubjects, trainActivities, trainMeasure)

testMeasure <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresExtracted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects   <- read.table("UCI HAR Dataset/test/subject_test.txt")
testData       <- cbind(testSubjects, testActivities, testMeasure)

# Merge train-test data together
allData <- rbind(trainData, testData)

############################################################################
# Appropriately labels the data set with descriptive variable names. (req.4)
############################################################################

colnames(allData) <- c("subject", "activity", featuresExtracted.names)

###############################################################################
# creates a second, independent tidy data (tidy.txt) set 
# with the average of each variable for each activity and each subject. (req.5)
###############################################################################

# To factor "activity" and "subject"
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject  <- as.factor(allData$subject)

# To use reshape2-melt function and mean to calculate the average of each variable
allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean   <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)